# EMI-An-Efficient-Algorithm-for-Identifying-Maximal-Rigid-Clusters-in-3D-Generic-Graphs
Including IMP, BMI, Trimmed-Base, Trim-FIX, automatic data generator, drawing program, and main Program

IdentifyMutuallyPairs is IMP.

OptimizeREP is Trim-FIX.

IdentifyRigidClusters is BMI and Trimmed-Base, corresponding to BMI when parameter flag = 0 and Trimmed-Base when flag = 1.

Generate_network_3d is an automatic data generator. The parameters that need to be controlled manually are: the "npoints" in the second line indicates the number of vertices, the "degree" in the third line indicates the average degree of vertices you expect, and the multiplier after "points" in the fourteenth line indicates a three-dimensional space. The size is set to 1000 by default (that is, the xyz coordinates of the vertices are all in the [-500, 500] interval), and the eleventh line "radius" indicates that there will be edges between vertices within the radius. The resulting undirected graph will not strictly satisfy M = degree * N, but the difference between the two sides of the equation will be within 10. 

ShowGraph is a drawing program. 

Main is the main program, which is the entry for the entire program to start.
The fourth line reads in the undirected graph, the format is: the first line has two numbers N and M, which represent the number of vertices and the number of edges, respectively, and the following M lines each have two numbers u and v, which represent the distance between the vertices u and v There are sides. The vertices must be numbered consecutively from 1-N, and the graph must have no multiple edges and self-loops. 
The eighth line reads the coordinates of N vertices, the format is: each line has three numbers x, y, z, and the i-th line represents the three-dimensional coordinates of vertex i. 
You can also delete the codes from line 4 to line 9 to automatically generate the coordinates of the undirected graph and vertices by running line 10 (that is, by running generate_network_3d). 
