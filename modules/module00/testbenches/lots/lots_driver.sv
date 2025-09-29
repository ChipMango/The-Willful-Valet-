// lifo test sequence
#10 park_car(32'h001); // Push 1st car
#10 park_car(32'h002); // Push 2nd car
#20 retrieve_car();    // Should get 002
#10 retrieve_car();    // Should get 001
