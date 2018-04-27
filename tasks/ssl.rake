# inspired by https://www.petekeen.net/know-how-to-roll-your-ssl-certificates
namespace :ssl do
  desc "Generate a new key"
  task :gen_key do
    domain = get_env(:domain)
    dest_dir = get_env(:dest_dir)
    filename = File.join(dest_dir, "#{domain}.key")

    `openssl genrsa -out #{filename} 2048`
  end

  desc "Generate a new CSR"
  task :gen_csr => :gen_key do
    domain = get_env(:domain)
    dest_dir = get_env(:dest_dir)
    csr_filename = File.join(dest_dir, "#{domain}.csr")
    key_filename = File.join(dest_dir, "#{domain}.key")

    `openssl req -new -utf8 -sha256 -key #{key_filename} -out #{csr_filename}`
    `cat #{csr_filename} | pbcopy`
  end

  desc "Sign certificate with CA"
  task :sign_csr do
    ca_cert = get_env(:ca_cert)
    ca_key = get_env(:ca_key)
    domain = get_env(:domain)
    dest_dir = get_env(:dest_dir)
    csr_filename = File.join(dest_dir, "#{domain}.csr")
    cert_filename = File.join(dest_dir, "#{domain}.ca-signed.pem")

    `openssl x509 -req -days 3650 -CA #{ca_cert} -CAkey #{ca_key} -CAcreateserial -in #{csr_filename} -out #{cert_filename}`
    `cat #{cert_filename} | pbcopy`
  end

  desc "Create a selfsigned cert"
  task :create_selfsigned do
    domain = get_env(:domain)
    dest_dir = get_env(:dest_dir)
    csr_filename = File.join(dest_dir, "#{domain}.csr")
    key_filename = File.join(dest_dir, "#{domain}.key")
    cert_filename = File.join(dest_dir, "#{domain}.pem")

    `openssl x509 -req -days 3650 -in #{csr_filename} -signkey #{key_filename} -out #{cert_filename}`
    `cat #{cert_filename} | pbcopy`
  end

  desc "Generate a proper nginx PEM file from PositiveSSL certificate download"
  task :assemble_cert do
    cert_dir = get_env(:cert_dir)
    domain = get_env(:domain)
    ssl_provider = get_env(:ssl_provider)
    pem_path = File.join(cert_dir, "#{domain}.pem")

    File.open(pem_path, 'w+') do |pem_file|
      cert_filename = domain.gsub(/\./, '_') + '.crt'
      pem_file.write(File.read(File.join(cert_dir, cert_filename)))
      
      case ssl_provider
      when 'comodo'
        pem_file.write(File.read(File.join(cert_dir, 'COMODORSADomainValidationSecureServerCA.crt')))
        pem_file.write(File.read(File.join(cert_dir, 'COMODORSAAddTrustCA.crt')))
      when 'positive'
        pem_file.write(File.read(File.join(cert_dir, 'PositiveSSLCA2.crt')))
      end

      pem_file.write(File.read(File.join(cert_dir, 'AddTrustExternalCARoot.crt')))
    end

    puts "Wrote pem to #{pem_path}"
  end

  def get_env(name)
    val = ENV[name.to_s]
    unless val && val != ''
      puts "Required env variable missing: #{name}" 
      exit 1
    end
    val
  end
end
