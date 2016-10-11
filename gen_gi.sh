#!/bin/bash

file_name=".gitignore"
echo -e ".git\n.vs\nDebug\nRelease\n*.swp\n*.o\n*.obj\n*.a\n*.lib\n*.so\n*.dll\n*.exe\n*.sdf\n*.suo\n*.filters\n" > $file_name

