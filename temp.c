#include <GL/gl.h>
#include <GL/glut.h>

void drawBitmapText(char *string,float x,float y,float z) 
{  
	char *c;
	glRasterPos3f(x, y,z);

	for (c=string; *c != '\0'; c++) 
	{
		glutBitmapCharacter(GLUT_BITMAP_HELVETICA_18  , *c);
	}
}

void display(void)
{
    glClear (GL_COLOR_BUFFER_BIT);
 
 glColor3f (0.0, 1.0, 0.0);
 glBegin(GL_LINES);
glVertex2f(10.00,18.00);
glVertex2f(4.00,16.00);
glVertex2f(10.00,18.00);
glVertex2f(8.00,16.00);
glVertex2f(10.00,18.00);
glVertex2f(12.00,16.00);
glVertex2f(10.00,18.00);
glVertex2f(16.00,16.00);
glVertex2f(4.00,16.00);
glVertex2f(6.67,14.00);
glVertex2f(8.00,16.00);
glVertex2f(13.33,14.00);
glEnd();
glColor3f (1.0, 1.0, 1.0);
drawBitmapText("khilaayaa",10.00,18.00,0);
drawBitmapText("maaM",4.00,16.00,0);
drawBitmapText("baccee",8.00,16.00,0);
drawBitmapText("khaanaa",12.00,16.00,0);
drawBitmapText("",16.00,16.00,0);
drawBitmapText("nee",6.67,14.00,0);
drawBitmapText("koo",13.33,14.00,0);
drawBitmapText(" maaM nee baccee koo khaanaa khilaayaa ",0.0,12.00,0);
drawBitmapText(" k1 lwg__psp k2 lwg__psp k2 main rsym",0.0,12.00-1.0,0);
drawBitmapText(" NN PSP:ने NN PSP:को NN VM .",0.0,12.00-2.0,0);
glFlush ();
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
    glutCreateWindow ("Dependency Tree");
    init ();
    glutDisplayFunc(display); 
    glutMainLoop();
    return 0;
}