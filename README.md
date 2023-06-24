# EMI-An Efficient Algorithm for Identifying Maximal Rigid Clusters in 3D Generic Graphs

The code here is the specific implementation of the algorithm mentioned in the paper "EMI: An Efficient Algorithm for Identifying Maximal Rigid Clusters in 3D Generic Graphs". The function of the code is to input a 3D undirected graph and output all rigid clusters in the graph. This document will tell you how to use these codes and explain the function of each .m file.

## The main program *Main.m*
*Main.m* is the main program, which is the entry for the entire program to start. By running Main.m you can make the whole program run. If you do nothing and run Main.m directly, it will give the execution result of our default example. If you want it to run on your given data, you can do it this way: 

## Input file format
If you want the input data to come from a file, then you need to prepare the input file. The input file contains an undirected graph data file and a vertex coordinate data file. Their format requirements are as follows: 

**Undirected graph data file**: The first line has two numbers N and M, which represent the number of vertices and the number of edges, respectively, and the following M lines each have two numbers u and v, which represent the distance between the vertices u and v There are sides. The vertices must be numbered consecutively from 1-N, and the graph must have no multiple edges and self-loops. 

**Vertex coordinate data file**: A total of N rows of data, each line has three numbers x, y, z, and the i-th line represents the three-dimensional coordinates of vertex i. 

If you still have doubts about the format, you can open the sample files Exp1-VE.txt and Exp1-P.txt, which are undirected graph data files and vertex coordinate data files respectively.

## Other files

**IdentifyMutuallyPairs.m**: This file is the specific implementation of *IMP* in the paper. 

**IdentifyRigidClusters.m**: This file implements the algorithms *BMI* and *Trimmed-Base*. Different algorithms can be implemented by adjusting the fourth parameter FLAG passed to *IdentifyRigidClusters* in line 17 of *Main.m*: when FLAG=0, *IdentifyRigidClusters* implements *BMI*; when FLAG=1, *IdentifyRigidClusters* implements *Trimmed-Base*. 

**OptimizeREP.m**: This file corresponds to *Trim-FIX*.

**ShowGraph.m**: This is the drawing program. 

**Exp1-P.txt** and **Exp1-VE.txt**: They are the sample input files. *Exp1-VE.txt* is an undirected graph data file with 200 vertices and 406 edges. *Exp1-VE.txt* includes the spatial coordinates of these 200 vertices. 
