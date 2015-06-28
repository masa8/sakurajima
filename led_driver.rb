require 'pi_piper'


class LEDDriver

##
# io_num : gpio ( default 25 )
# in_out : :in or :out
def initialize(io_num = 25, in_out = :out)
 @pin = PiPiper::Pin.new(:pin => io_num, :direction => in_out)
end
def on()
 @pin.on
end

def off()
 @pin.off
end

end


