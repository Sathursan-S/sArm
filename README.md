# sArm
##

Introduction

A robotic arm is a type of mechanical arm, usually programmable, with similar functions to a human arm. current days robotic arms are becoming a replacement for humans in working tasks, especially repetitive tasks. They are more efficient and accurate than humans. Robotic arms are currently used in many fields such as medical, space, nuclear and other researches, industries, education, etc.

when thinking about robotic arms, what comes to mind is their high price, big size and complexity. For students and small industries, it has been not possible to access a better robotic arm for educational or industrial purposes. In this mini-project, a robotic arm manipulator was built to resolve that problem. It has many facilities such as

- GUI manipulator

- IoT (Internet of Things) controllability

- Inverse kinematic

- Programmable

- Multiple platform support

- Educational value

- Low cost and open source

With these utilities, a fully functional robot arm can be afforded for home, school and professional use. This robotic arm will help to study robotics, learn to code, automate works and bring peoples ideas to real life. With its' IoT controllability it can do more things like remote access from any ware, safe nuclear researches, make a global network for robot arms, implement ML(Machine Learning) and AI (Artificial Intelligence) with IoT cloud, etc. it opens a new space for makers, robot enthusiasts, engineers and students to explore robotics. This robotic arm is named as sArm.

##

Methodoligy

The concept of this project is controlling a servo based robotic arm through a microcontroller (Arduino UNO) and the microcontroller is controlled in different ways such as connect the microcontroller to IoT and control it, program the microcontroller for a specific task, connect the microcontroller to a computer and control it in various ways like GUI simulation control.

Components

- Arduino UNO R3 ATMEGA328 SMD CH340 with Cable.

- Micro servo SG90 Tower Pro.

- Connecting wires.

Mechanical design

The robotic arm used here is a miniature model based on ABB IRB 460 Palletizing Robot mechanism. It has 4 degrees of freedom (DOF). It is powered by four micro servos. In this case, an open-source robot model mearm is used for the prototype (Thingiverse.com, 2016).

![image.png](https://hackster.imgix.net/uploads/attachments/1485809/image_TXX9z1E421.png?auto=compress%2Cformat&w=740&h=555&fit=max)

![image.png](https://hackster.imgix.net/uploads/attachments/1485810/image_1fgYcfmyHF.png?auto=compress%2Cformat&w=740&h=555&fit=max)

![image.png](https://hackster.imgix.net/uploads/attachments/1485780/image_YvfEzknbW0.png?auto=compress%2Cformat&w=740&h=555&fit=max)

Electronic design

This robotic arm is controlled by an Arduino UNO microcontroller. Servos in the assembled robotic arm are connected to Arduino like in the Schematics.

Inverse kinematics

Inverse kinematics is one of the most important things for manipulating robotic arms effectively. inverse kinematics is the mathematical process of calculating the joint angles from the position of the end-effector. In this case, three controllable joints are there. Base to arm joint (𝜃3), solder joint (𝜃1), elbow joint (𝜃2). They are founded with trigonometric.

![image.png](https://hackster.imgix.net/uploads/attachments/1485782/image_y0mi14WRZq.png?auto=compress%2Cformat&w=740&h=555&fit=max)

![image.png](https://hackster.imgix.net/uploads/attachments/1486040/image_uzC9GJkwJ6.png?auto=compress%2Cformat&w=740&h=555&fit=max)

Control with basic Arduino code

In this case, the robot is programmed to do certain work. Some functions were written to program the arm easily. Those functions are based on inverse kinematics.



##
Blynk based IoT control

This system is made with an IoT platform called Blynk (Blynk, 2021). It is one of the best platforms for IoT beginners. First, a mobile application made with the Blynk application that is very easy with Blynk widgets. and in this case, Arduino was coded and connect to IoT through a USB connection with a PC. There is no need for any Wi-Fi modules with Blynk USB support. Local Blynk servers also build easily with the Blynk server library.

![image.png](https://hackster.imgix.net/uploads/attachments/1485817/image_Y8ejrupzMG.png?auto=compress%2Cformat&w=740&h=555&fit=max)

##GUI Based Manipulator

Graphical User Interface is the best way for beginners to manipulate. And also, this GUI manipulator has more features than others such as Record and Play mode, simulation-based controller. This system works on two modes one is with sArm manipulator software and wired connection via USB and the other is IoT control with the web-based manipulator.

##
PC software sArm Manipulator

This software was built with the Processing IDE and the JAVA (Ben Fry, 2020). This software controls the Arduino through serial communication with Firmata protocol (soundanalogous, 2021).

![image.png](https://hackster.imgix.net/uploads/attachments/1485818/image_mcymfrsJ6M.png?auto=compress%2Cformat&w=740&h=555&fit=max)

The above block diagram [Figure 8.7] shows the concept of this system. the Firmata protocol is used to make serial communication between the Arduino and the processing. To do that the Arduino was uploaded with StandedFirmatPlus.ino from the Firmata library. a GUI controller was built with the Processing by the following Java code.

##
Web-based sArm manipulator

This web-based manipulator made to control the robotic arm through IoT with simulation. This is made with node.js, p5.js, and johnny-five library for p5.js (p5.j5) (Montes, 2020). This web-based manipulator is hosted from a node.js server and the server communicate with the Arduino by serial communication through the Firmata protocol via USB. The server has three web pages one is for connect the Arduino, one is for the GUI manipulator desktop version and another is for the mobile version. The code for this system was written in JavaScript. the flowing block diagram explains this system.

![image.png](https://hackster.imgix.net/uploads/attachments/1485819/image_hZTikNaNOX.png?auto=compress%2Cformat&w=740&h=555&fit=max)

##

Result

-Control sArm with the Arduino code

This code and functions that are mentioned in the methodology are working very well. Many different tasks are coded with these functions and tested. It was easier than the typical coding. For example with six drawLine() function can move the end effector in a hexogen path.

- Blynk based IoT control

Blynk can work with both the official Blynk server and the local Blynk server. Both are working well with sArm but the official Blynk server give limited access for free but the local server has no limitation. With the Blynk two type of interfaces was built and tested. One is a basic joint based controller it works through the official Blynk server and another interface works with the basic joint based controller, inverse kinematic based coordinate control and record and plays mode this is based on the local Blynk server.

This system is very good for beginners to experiment and play with the IoT and the robotic.

![image.png](https://hackster.imgix.net/uploads/attachments/1485789/image_n3M6orlYcn.png?auto=compress%2Cformat&w=740&h=555&fit=max)

![image.png](https://hackster.imgix.net/uploads/attachments/1485790/image_GXZzKQrj3X.png?auto=compress%2Cformat&w=740&h=555&fit=max)

-   GUI based Manipulator

This category has two types of manipulators one is a software controller and another is a web-based manipulator through the IoT. Desktop software has facilities such as control with simulation, record and play mode and slider control also. The sArm can be controlled by clicking and dragging the mouse on the simulation model. While controlling this way sArm use the connected computers' CPU to do processing so, it is very powerful to do heavy processing tasks and it has a very accurate record and play mode than basic Arduino control because it uses the computer RAM to seave positions so it can seave more data than Arduino. Automate the sArm is very easy with this manipulator.

![image.png](https://hackster.imgix.net/uploads/attachments/1485794/image_ZPrfkwWHOj.png?auto=compress%2Cformat&w=740&h=555&fit=max)

- Web-based GUI manipulator

This is the IoT version of the above GUI manipulator and it also has a mobile version too. There are three web pages one is for connecting the Arduino through serial comminution this should be done from a compute that connected to sArm via USB, and others are for manipulators for desktop and mobile these can be run through the internet.

![image.png](https://hackster.imgix.net/uploads/attachments/1485795/image_Bpw6RRax24.png?auto=compress%2Cformat&w=740&h=555&fit=max)

![image.png](https://hackster.imgix.net/uploads/attachments/1485796/image_GdwMZsvePo.png?auto=compress%2Cformat&w=740&h=555&fit=max)

![image.png](https://hackster.imgix.net/uploads/attachments/1485797/image_m90kuOHykk.png?auto=compress%2Cformat&w=740&h=555&fit=max)

![image.png](https://hackster.imgix.net/uploads/attachments/1485798/image_0tCdtzAQiT.png?auto=compress%2Cformat&w=740&h=555&fit=max)
