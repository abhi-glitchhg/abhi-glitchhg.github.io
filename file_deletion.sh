#!/bin/sh
sudo rm -rf /home/abhijit/cv/latex/cv.aux 
sudo rm -rf /home/abhijit/cv/latex/cv.fls
sudo rm -rf /home/abhijit/cv/latex/cv.log
sudo rm -rf /home/abhijit/cv/latex/cv.out
sudo rm -rf /home/abhijit/cv/latex/cv.fdb_latexmk
sudo rm -rf /home/abhijit/cv/latex/cv.synctex.gz

echo "removed log files" 

sudo rm -rf /home/abhijit/cv/pdf/cv.pdf

mv /home/abhijit/cv/latex/cv.pdf /home/abhijit/cv/pdf/cv.pdf

GIT='git --git-dir='$PWD'/.git'
$GIT add .
$GIT commit -m "cv updated"
$GIT push 


echo "cv file will be deleted in website"
pushd /home/abhijit/vscode/youtube/mywebsite/abhi-glitchhg/files
sudo rm -rf /home/abhijit/vscode/youtube/mywebsite/abhi-glitchhg/files/cv.pdf
popd 

cp /home/abhijit/cv/pdf/cv.pdf /home/abhijit/vscode/youtube/mywebsite/abhi-glitchhg/files/cv.pdf
echo "moved"


echo "another website moved"
GIT='git --git-dir=/home/abhijit/vscode/youtube/mywebsite/abhi-glitchhg/.git'
$GIT add .
$GIT commit -m "cv updated"
$GIT push 
