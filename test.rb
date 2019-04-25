require 'openssl'

def renMD5(val)
    OpenSSL::Digest::MD5.digest(OpenSSL::Digest::MD5.digest(val)).bytes.take(7).pack("C*")
end
input1 = '416084a95c531ab195ba'
string1 = input1.scan(/../).map { |x| x.hex.chr }.join
input2 = '416084f62699856189b6'
string2 = input2.scan(/../).map { |x| x.hex.chr }.join

puts "input1 #{input1}"
puts "input2 #{input2}"
puts "hash for input1 #{renMD5(string1).bytes.map{|b| b.to_s(16)}.join}"
puts "hash for input2 #{renMD5(string2).bytes.map{|b| b.to_s(16)}.join}"



