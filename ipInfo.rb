valid = true

print "ip: "
ip = gets.strip.to_s
ip = ip.split(".")
puts

if ip.length() != 4
 valid = false
end

for i in 0 ... ip.size
  if ip[i].to_i > 255
    valid = false
  end
end

if ip[0].to_i == 0
  valid = false
end

if ip[0].to_i <= 126 and ip[0].to_i != 0
  classification = "a"

elsif ip[0].to_i == 127
  classification = "localhost"

elsif ip[0].to_i <= 191
  classification = "b"

elsif ip[0].to_i <= 255
  classification = "c"
end

hostAdd = ""

case classification
when "a"
  mask = "255.0.0.0"
  networkAdd = "#{ip[0]}"
  hostAdd = "#{ip[1]}.#{ip[2]}.#{ip[3]}"
  type = (ip[0].to_i == 10) ? "private" : "public"

when "b"
  mask = "255.255.0.0"
  networkAdd = "#{ip[0]}.#{ip[1]}"
  hostAdd = "#{ip[2]}.#{ip[3]}"
  type = (ip[0].to_i == 172 and (ip[1].to_i>=16 and ip[1].to_i<=31)) ? "private" : "public"


when "c"
  mask = "255.255.255.0"  
  networkAdd = "#{ip[0]}.#{ip[1]}.#{ip[2]}"
  hostAdd = "#{ip[3]}"
  type = (ip[0].to_i == 192 and ip[1].to_i == 168) ? "private" : "public"

when "localhost"
   
else
  valid = false
end

hostArr = hostAdd.split(".")
net = 0
brod = 0
for i in 0 ... hostArr.size
  if hostArr[i].to_i == 0
    net += 1
  end
  if hostArr[i].to_i == 255
    brod += 1
  end
end

if net == hostArr.size
  type = "network"
end
if brod == hostArr.size
  type = "broadcast"
end  

if (valid)
  if ip[0].to_i == 172
    puts "localhost"
  else
    puts "class . . . . . . . . : #{classification.upcase}"
    puts "mask. . . . . . . . . : #{mask}"
    puts "network address . . . : #{networkAdd}"
    puts "host address. . . . . : #{hostAdd}"
    puts "type. . . . . . . . . : #{type}"
  end
else
  puts "not valid"
end
