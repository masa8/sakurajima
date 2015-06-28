require './sakurajima_data_provider'
require './led_driver'

 dp = SakurajimaDataProvider.new
 led = LEDDriver.new
 loop {

 if dp.erupted?
  puts "YES"
  led.on
 else
  puts "no"
  led.off 
 end
 sleep(300)
 }
