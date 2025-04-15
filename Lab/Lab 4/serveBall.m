% D. Kaputa
% serveBall.m
% Ravvenlabs

clc;
clear all;
close all;

%Initialization Parameters
server_ip   = '127.0.0.1';     %IP address of the Unity Server
server_port = 55001;           %Server Port of the Unity Sever

client = tcpclient(server_ip,server_port,"Timeout",20);
fprintf(1,"Connected to server\n");

width = 752;
height = 480;

x = 1; y = 1; z = 5;
image = blenderLink(client,width,height,x,y,z,0,0,0,"tennisBall");

x = 1; y = -0.03; z = 10;
imageLeft = blenderLink(client,width,height,x,y,z,0,0,90,"Camera");

x = 1; y = +0.03; z = 10;
imageRight = blenderLink(client,width,height,x,y,z,0,0,90,"Camera");

subplot(1,2,1)
imagesc(imageLeft)
subplot(1,2,2)
imagesc(imageRight)
set(gcf, 'Position', get(0, 'Screensize'));
axis off