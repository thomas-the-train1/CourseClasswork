#
#  Parser Class
#
load "TinyToken.rb"
load "TinyLexer.rb"
class Parser < Lexer
	
	def initialize(filename)
    super(filename)
		@error_count = 0
    consume()
  end
   	
	def consume()
    @lookahead = nextToken()
    while (@lookahead.type == Token::WS)
      @lookahead = nextToken()
    end
  end
  	
	def match(dtype)
    if (@lookahead.type != dtype)
      puts "Expected #{dtype} found #{@lookahead.text}"
      @error_count += 1
    end
    consume()
  end
   	
	def program()
    while (@lookahead.type != Token::EOF)
			puts "Entering STMT Rule"
			statement()  
    end
		puts "There were #{@error_count} parse errors found."
  end

	def statement()
		if (@lookahead.type == Token::PRINT)
			puts "Found PRINT Token: #{@lookahead.text}"
			match(Token::PRINT)
			puts "Entering EXP Rule"
			exp()
		else
			puts "Entering ASSGN Rule"
			assign()
		end
		puts "Exiting STMT Rule"
	end

	def assign()
    if (@lookahead.type == Token::ID)
      puts "Found ID Token: #{@lookahead.text}"
			match(Token::ID)
		end	
		if (@lookahead.type == Token::ASSGN)	
			match(Token::ASSGN)	
		else
      expected = "="
      found = @lookahead.type == Token::EOF ? "eof" : @lookahead.text
      puts "Expected #{expected} found #{found}"
      @error_count += 1
      consume()	
		end
		puts "Entering EXP Rule"	
    exp()
    puts "Exiting ASSGN Rule"
	end

	def exp()
		puts "Entering TERM Rule"
		term()
		puts "Entering ETAIL Rule"
		etail()
		puts "Exiting EXP Rule"
	end

	def term()
		puts "Entering FACTOR Rule"
		factor()
		puts "Entering TTAIL Rule"
		ttail()
		puts "Exiting TERM Rule"
	end

	def factor()
    if (@lookahead.type == Token::LPAREN)
      puts "Found LPAREN Token: #{@lookahead.text}"
      match(Token::LPAREN)
			puts "Entering EXP Rule"
			exp()
      if (@lookahead.type == Token::RPAREN)
        puts "Found RPAREN Token: #{@lookahead.text}"
      end
			match(Token::RPAREN)
		elsif (@lookahead.type == Token::INT)
			puts "Found INT Token: #{@lookahead.text}"
			match(Token::INT)
		elsif (@lookahead.type == Token::ID)
		 	puts "Found ID Token: #{@lookahead.text}"
		 	match(Token::ID)	
		else
			# match(Token::LPAREN, Token::INT, Token::ID)
			expected_tokens = ["(", "INT", "id"]
      found = @lookahead.type == Token::EOF ? "eof" : @lookahead.text
      puts "Expected #{expected_tokens.join(" or ")} found #{found}"
      @error_count += 1
      consume()
		end
		puts "Exiting FACTOR Rule"
	end

	def ttail()
		if (@lookahead.type == Token::MULTOP)
			puts "Found MULTOP Token: #{@lookahead.text}"
			match(Token::MULTOP)
			puts "Entering FACTOR Rule"
			factor()
			puts "Entering TTAIL Rule"
			ttail()
		elsif (@lookahead.type == Token::DIVOP)
			puts "Found DIVOP Token: #{@lookahead.text}"
			match(Token::DIVOP)
			puts "Entering FACTOR Rule"
			factor()
			puts "Entering TTAIL Rule"
			ttail()
		else
			puts "Did not find MULTOP or DIVOP Token, choosing EPSILON production"	
		end
		puts "Exiting TTAIL Rule"
	end

	def etail()
		if (@lookahead.type == Token::ADDOP)
			puts "Found ADDOP Token: #{@lookahead.text}"
			match(Token::ADDOP)
			puts "Entering TERM Rule"
			term()
			puts "Entering ETAIL Rule"
			etail()
		elsif (@lookahead.type == Token::SUBOP)
			puts "Found SUBOP Token: #{@lookahead.text}"
			match(Token::SUBOP)
			puts "Entering TERM Rule"
			term()
			puts "Entering ETAIL Rule"
			etail()
		else
			puts "Did not find ADDOP or SUBOP Token, choosing EPSILON production"	
		end
		puts "Exiting ETAIL Rule"
	end	
	
end
