require 'digest'
require 'securerandom'
require 'openssl'
$indeks = [0x41,0x60,0x84].pack("C*")
def renMD5(val)
    OpenSSL::Digest::MD5.digest(OpenSSL::Digest::MD5.digest($indeks + val)).bytes.take(7).pack("C*")
end
while true
    initial = SecureRandom.hex
    puts "initial value: #{initial}"
    tortoise = renMD5(initial)
    hare = renMD5(renMD5(initial))
    counter = 0
    while tortoise != hare
        if counter % 1000000 == 0 then puts counter end
        tortoise = renMD5(tortoise)
        hare = renMD5(renMD5(hare))
        counter+=1
    end
    puts "cycle found, starting second phase"
    tortoise = renMD5(initial)
    tortoise_last = 0
    hare_last = 0
    while tortoise != hare
        tortoise_last = tortoise
        hare_last = hare
        tortoise = renMD5(tortoise)
        hare = renMD5(hare)
    end
    input1 = ($indeks + tortoise_last).bytes.map{|b| b.to_s(16)}.join()
    input2 = ($indeks + hare_last).bytes.map{|b| b.to_s(16)}.join()
    puts "Collision found for #{input1.bytes} and #{input2.bytes}"
    puts "MD5 for #{input1} is #{renMD5($indeks + tortoise_last)}"
    puts "MD5 for #{input2} is #{renMD5($indeks + hare_last)}"
    File.open(initial, 'w') do |f|
        f << input1
        f << "\n"
        f << input2
    end
end