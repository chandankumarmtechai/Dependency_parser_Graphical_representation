    use strict;
    use warnings;
    use 5.010;
    use Data::Dumper qw(Dumper);
    use utf8;
    use Encode;

    my @root;
    my @level;
    my $size = 2;
    my $i = 0;
    my @edge;
    my %pos;
    my %xcord;
    my %ycord;
    my $command = "cut -f1,2 sentence | sed 's/\\t/\\n/g'";
    my $tagcommand = "cut -f6 sentence";
    my $poscommand = "cut -f4 sentence";
    my @ar;
    my %label;
    my $depth = 18.0;
    my @vertex;
    my @names;
    my $result;
    my $line;
    my @tag;
    my $tagline;
    my @pos;
    my $posline;
    
    my $filename = 'temp.c';
    my $fh;
    
    my $begin = "#include <GL/gl.h>
#include <GL/glut.h>

void drawBitmapText(char *string,float x,float y,float z) 
{  
	char *c;
	glRasterPos3f(x, y,z);

	for (c=string; *c != '\\0'; c++) 
	{
		glutBitmapCharacter(GLUT_BITMAP_HELVETICA_18  , *c);
	}
}

void display(void)
{
    glClear (GL_COLOR_BUFFER_BIT);
 
 glColor3f (0.0, 1.0, 0.0);
 glBegin(GL_LINES);";
 
	my $end = "glFlush ();
}

void init (void) 
{
    glClearColor (0.0, 0.0, 0.0, 0.0);

    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    glOrtho(0.0, 20.0, 0.0, 20.0, -20.0, 20.0);
}

int main(int argc, char** argv)
{
    glutInit(&argc, argv);
    glutInitDisplayMode (GLUT_SINGLE | GLUT_RGB);
    glutInitWindowSize (1000, 650); 
    glutInitWindowPosition (150, 300);
    glutCreateWindow (\"Dependency Tree\");
    init ();
    glutDisplayFunc(display); 
    glutMainLoop();
    return 0;
}"; 


my $rf;
 my $wf;
 my $readfile = $ARGV[0];
    open($rf, '<:encoding(UTF-8)', $readfile) or die "Could not open file '$readfile' $!";
      
    my $writefile = 'sentence';
    open($wf, '>', $writefile) or die "Could not open file '$writefile' $!";
    
    while (my $row = <$rf>) 
    {
      chomp $row;
      if($row ne "")
      {
      	print $wf "$row\n";
      }
      else
      {
        close $wf;
        resett();
        main1();
        say "Do you want to continue -- yes/no ";
        my $user = <STDIN>;
        chomp $user;
        if($user eq "yes")
        {
        	open($wf, '>', $writefile) or die "Could not open file '$writefile' $!";
        }
        elsif($user eq "no")
        {
        	exit;
        }
      }
      #close $wf;
    }
    close $wf;
    

#resett();

sub resett
{
	foreach my $i (0 .. $#level) 
	{
		shift @level;
	}
	foreach my $j (0 .. $#edge) 
	{
		shift @edge;
	}
	foreach my $k (0 .. $#vertex) 
	{
		shift @vertex;
	}
	foreach my $l (0 .. $#names) 
	{
		shift @names;
	}
	
	foreach my $m(0 .. $#root) 
	{
		shift @root;
	}
	foreach my $n(0 .. $#ar) 
	{
		shift @ar;
	}
	
	foreach my $key (keys %xcord)
	{
  		delete($xcord{$key});
	}
	
	foreach my $key (keys %ycord)
	{
  		delete($ycord{$key});
	}
	
	foreach my $key (keys %label)
	{
  		delete($label{$key});
	}
	foreach my $p (0 .. $#tag) 
	{
		shift @tag;
	}
	
	@root = `grep "0" sentence -w | cut -f1`;
    @ar = `$command`;
    pop @ar;
	foreach my $v (@ar) {
         chomp($v);
       }
    %label = @ar;
    @tag = `$tagcommand`;
    @pos = `$poscommand`;
    $result = "";
    $line = "";
    $tagline = "";
    $posline = "";
}

#main1();

sub main1
{
foreach my $v (@root) {
         chomp($v);
       }

foreach my $vv (@root) 
{
	foreach my $i (0 .. $#level) 
	{
		shift @level;
	}
	foreach my $j (0 .. $#edge) 
	{
		shift @edge;
	}
	foreach my $k (0 .. $#vertex) 
	{
		shift @vertex;
	}
	foreach my $l (0 .. $#names) 
	{
		shift @names;
	}
	@level = $vv;
	push @level, "\n" ;

	createlevel();
	xyz();
	abc();
	final();
	execute();
}
}

sub createlevel
{
	$i = 0;
	while($i < $size) 
	{
	if($level[$i] ne "\n")
	{
		my @temp = `grep "\t$level[$i]\t" sentence -P | cut -f1`; 
		foreach my $v (@temp) 
		{
         chomp($v);
       	}
	foreach my $x (@temp) 
	{
         push  @level, $x;
         push  @edge, $level[$i];
         push  @edge, $x;
    }

	}
	elsif($i != $size-1)
	{
		push  @level, "\n";
	}
	$size = scalar @level;
#say "iteration$i";
	$i++;
	}
}

#xyz();

sub xyz
{
	my $points;
	my $step;
	my $xx; 
	my @temp;
	my $sft;
	my $str;
	my $var;
	
	$depth = sprintf("%.2f",18.00);
	foreach my $y (@level) 
	{
		if($y ne "\n")
		{
			push @temp, $y;
		}
		else
		{
	     	$points = scalar @temp + 1.0;
			$step = 20.0/$points;
			$xx = $step;
           # say $points;
			foreach my $i (0 .. $#temp) 
			{
				$sft = shift @temp;
				$var = sprintf("%.2f", $xx);
				$xcord{$sft}= $var;
				$ycord{$sft}= sprintf("%.2f",$depth);
				$xx = $xx + $step;
				#drawBitmapText("tree",10.0,19.0,0);
				#trans($label{$sft});
				#say $result;
				call($label{$sft});
				chomp($result);
				$str = "drawBitmapText(\"$result\",$var,$depth,0);";
				push @names,$str;
			}

			$depth = sprintf("%.2f",$depth-2.0);
		}
	}
	
	for my $fr (keys %xcord) 
	{
        #print "The xcord'$fr' is $xcord{$fr}\n";
    }
    
    for my $f (keys %ycord) 
	{
        #print "The ycord'$f' is $ycord{$f}\n";
    }
}

#  glVertex2f(-0.5f, -0.5f);

#abc();

sub abc
{
	my $i=0;
	my $str1;
	my $str2;
	my $x;
	my $y;
	
	while($i < $#edge)
	{
		$x = $xcord{$edge[$i]};
		$y = $ycord{$edge[$i]};
		$str1 = "glVertex2f($x,$y);";
		
		$x = $xcord{$edge[$i+1]};
		$y = $ycord{$edge[$i+1]};
		$str2 = "glVertex2f($x,$y);";
		
		push @vertex, $str1;
		push @vertex, $str2;
		
		#say "hi";
		
		$i = $i + 2;
	} 
}
#final();
sub final
{
	open($fh, '>', $filename) or die "Could not open file '$filename' $!";
	say $fh $begin;
	foreach my $z (@vertex)
	{
		say $fh $z;
	}
	say $fh "glEnd();";
	say $fh "glColor3f (1.0, 1.0, 1.0);";
	
	foreach my $xy (@names)
	{
	 	say $fh $xy;
	}
	$line = "";
	$tagline = "";
	foreach my $text (sort {$a <=> $b} keys %label) {
        call($label{$text});
        chomp($result);
        $line = $line." ";
        $line = $line.$result;
    }
    foreach my $tt (@tag)
    {
    	chomp($tt);
    	$tagline = $tagline." ";
    	$tagline = $tagline.$tt;
    }
    
    foreach my $pp (@pos)
    {
    	chomp($pp);
    	$posline = $posline." ";
    	$posline = $posline.$pp;
    }
    
	say $fh "drawBitmapText(\"$line\",0.0,$depth,0);";
	say $fh "drawBitmapText(\"$tagline\",0.0,$depth-1.0,0);";
	say $fh "drawBitmapText(\"$posline\",0.0,$depth-2.0,0);";
	print $fh $end;
}

sub call
{
my ($hash) = shift;
my $run = "sed 's/my \\\$var = \".*\"/my \\\$var = \"$hash\"/g' copy.pl > copy1.pl";
system("$run");
system("mv copy1.pl copy.pl");
my $x = "perl copy.pl";
$result = `$x`;
#print "$result";
}

#execute();

sub execute
{
	#system("perl tree.pl > temp.c");
	close $fh;
	#system("gcc temp.c -o temp -lGL -lglut -lGLU");
	system("gcc temp.c -o temp -lglut -lGL -lGLU -lm -lX11 -lm");
	system("./temp&");
}

