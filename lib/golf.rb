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
      (0..a.length-1).map { |x|
        (x..a.length-1).map { |y|
          a[x..y]
        }.sort
      }.flatten(1).sort_by { |l| l.join.to_i }
    end
    
    F = "fizz"
    B = "buzz"
    
    def hole6(x)
      (1..x).map { |i|
        case true
        when i % 3 == 0 && i % 5 == 0
          F + B
        when i % 3 == 0
          F
        when i % 5 == 0
          B
        else
          i
        end
      }
    end
    
    def hole7(a)
      [].tap { |ranges|
        s = nil
        a.each_with_index { |e, i|
          if i == 0
            s = e
          elsif (i == a.length-1)
            ranges << "#{s}-#{e}"
          else          
            if e > (l = a[i-1])+1
              ranges << ((s == l) ? s.to_s : "#{s}-#{l}")
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
      votes = File.readlines(p).map { |v| v.strip.split(", ") }
      post = votes.length.to_f / 2.0
      winner = nil
      eliminated = []
      round = 0
      until winner || (round == 6)
        results = votes.map { |v| v[0] }
        results = results.sort_by { |c| results.grep(c).length }.compact
        if results.uniq.length == 2
          winner = results.last
        else
          round_winner = results.last
          round_loser  = results.first
          if results.grep(round_winner).length > post
            winner = round_winner
          else
            votes.each { |v|
              v.delete(round_loser)  
            }
          end
        end
        round += 1
      end
      winner
    end
  end
end
