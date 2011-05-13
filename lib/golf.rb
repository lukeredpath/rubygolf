require 'ap'

class Golf
  class << self
    def hole1(a)
      a.inject &:*
    end
    
    def hole2(a)
      a.split(" ").sort_by { |w| w[1] }.join " "
    end
    
    def hole3(i)
      (1..i).inject &:*
    end
    
    def hole4(a)
      a.map { |i| 
        i =~ /^(.*)\(/
        case $1
          when "man"
            "hat(#{i})"
          when "dog"
            "#{i[0..-2]}(bone))"
          when "cat"
            i.sub(/cat/, "dead")
        end
      }
    end
    
    def hole5(a)
      (1..a.size).map { |x| a.each_cons(x).to_a }.flatten(1)
    end
    
    F = "fizz"
    B = "buzz"
    
    def hole6(x)
      (1..x).map { |i|
        if i % 15 == 0
          F + B
        elsif i % 3 == 0
          F
        elsif i % 5 == 0
          B
        else
          i
        end
      }
    end
    
    def hole7(a)
      [].tap { |r|
        s = nil
        a.each_with_index { |e, i|
          if i == 0
            s = e
          elsif (i == a.size-1)
            r << "#{s}-#{e}"
          else          
            if e > (l = a[i-1])+1
              r << ((s == l) ? s.to_s : "#{s}-#{l}")
              s = e
            end
          end
        }
      }
    end
    
    def hole8(i)
      (i-1).times.inject([1]) { |a, x|
        a << ((x == 0) ? 0 : a[x-1]) + (a[x])
      }
    end
    
    def hole9(p)
      v = File.readlines(p).map { |l| l.strip.split(", ") }
      p = v.size.to_f / 2.0
      w = nil
      r = 0
      until w
        x = v.map { |i| i[0] }
        x = x.sort_by { |c| x.grep(c).size }.compact
        if x.uniq.size == 2
          w = x.last
        else
          a = x.last
          z = x.first
          if x.grep(a).size > p
            w = a
          else
            v.each { |i|
              i.delete(z)  
            }
          end
        end
        r += 1
      end
      w
    end
  end
end
