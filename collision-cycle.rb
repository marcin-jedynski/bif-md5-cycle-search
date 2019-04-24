require 'digest'
require 'securerandom'
require 'openssl'

$indeks = [0x41,0x60,0x84].pack("C*")
def renMD5(val)
    OpenSSL::Digest::MD5.digest(OpenSSL::Digest::MD5.digest($indeks + val)).bytes.take(7).pack("C*")
end

while true
    init = SecureRandom.hex
    puts "inital value: #{init}"
    tortoise = renMD5(init)
    hare = renMD5(renMD5(init))

    counter = 0
    while tortoise != hare
        if counter % 1000000 == 0 then puts counter end
        tortoise = renMD5(tortoise)
        hare = renMD5(renMD5(hare))
        counter+=1
    end

    puts "counter: #{counter}"
    puts "tortise: #{tortoise.bytes}"
    puts "hare: #{hare.bytes}"
    tortoise = renMD5(init)

end