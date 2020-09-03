    use strict;
    use warnings;
    use 5.010;
    use Data::Dumper qw(Dumper);
    use utf8;

    my $str = "प्रयोग कमल गेन्दा परीक्षण";
    my $var = "";
    my $arg = $var;
    my $result;
    
    my %consonant=
    (
    	 	"क" => "k",
    	 	"ख" => "kh",
    	 	"ग" => "g",
    	 	"घ" => "gh",
    	 	
    	 	"च" => "c",
    	 	"छ" => "ch",
    	 	"ज" => "j",
    	 	"झ" => "jh",
    	 	
    	 	"ट" => "T",
    	 	"ठ" => "Th",
    	 	"ड" => "D",
    	 	"ढ" => "Dh",
    	 	"ण" => "N",
    		"त" => "t",
    		"थ" => "th",
    		"द" => "d",
    		"ध" => "dh",
    		"न" => "n",
		"प" => "p",
		"फ" =>"ph",
		"ब" => "b",
		"भ" => "bh",
		"म" => "m",
		"य" => "y",
		"र" => "r",
		"ल" => "l",
		"व" => "v",
		"ह" => "h",
		"स" => "s",
		"श" => "sh",
		"ष" =>  "Sh",
     );
     
     my %vowel=
     (
     		"अ" => "a",
     		"आ" => "aa",
     		"इ" => "i",
     		"ई" => "ii",
     		"उ" => "u",
     		"ऊ" => "uu",
     		"ए" => "ee",
     		"ऐ" => "ai",
     		"ओ" => "oo",
     		"औ" => "au",
     		"अं" => "M",
     		"ऋ"  => "RR",
     );
     
     my %matra=
     (
     		"ा" => "aa",
     		"ि" => "i",
     		"ी" => "ii",
     		"ु" =>  "u",
     		"ू" => "uu",
     		"े" => "ee",
     		"ै" => "ai",
     		"ो" => "oo",
     		"ौ" => "au",
     		"ं" => "M",
     		"ः" => "H",
     );
     
     trans($arg);
     
     sub trans
     {
		$result = "";     		
		my ($str2) = shift;
     		my $temp;
     		my $len = length $str2;
     		foreach my $i (0 .. $len)
     		{
     			$temp = substr $str2, $i, 1;
     			if(defined $consonant{$temp})
     			{
				$result = $result . $consonant{$temp};
     				if($i != $len -1 )
     				{
     					if(defined $consonant{substr $str2, $i+1, 1})
     					{
							$result = $result . "a";
     					}
     				}
     				elsif($i == $len-1)
     				{
     					$result = $result ."a";
     				}
     			}
     			elsif(defined $vowel{$temp})
     			{
     				$result = $result . $vowel{$temp};
     			}
     			elsif(defined $matra{$temp})
     			{
     				$result = $result . $matra{$temp};
     			}
     			else
     			{
     				#say "$temp not recog";
     			}
     		}
     }
  
    print "$result\n";
