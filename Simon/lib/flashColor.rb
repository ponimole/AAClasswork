require "colorize"
class FlashColor
    attr_reader :print

    def initialize(color = nil)
        @grid = Array.new(20) {Array.new(50," ")}
        @color = color
    end

    def print
       color = [:red, :blue, :green, :yellow]
       color_light = [:light_red, :light_blue, :light_green, :light_yellow]

       if @color != nil
        idx = color.index(@color)
        color[idx] = color_light[idx]
       end
       system "clear"
        @grid.each_with_index do |row,r_i|
            
            print_row = ""
            row.each_with_index do |pixel,c_i|
                if r_i < 9 && c_i < 23
                    print_row += pixel.colorize(:background => color[0])
                elsif r_i < 9 && c_i >= 27
                    print_row += pixel.colorize(:background => color[1])
                elsif r_i >= 11 && c_i < 23
                    print_row += pixel.colorize(:background => color[2])
                elsif r_i >= 11 && c_i >= 27
                    print_row += pixel.colorize(:background => color[3])
                else
                    print_row += " "
                end
            end
            puts print_row
        end
    end
end