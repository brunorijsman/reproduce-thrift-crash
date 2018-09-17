struct Coordinate {
    1: required i32 x;
    2: required i32 y;
}

struct Terrain {
    1: required map<Coordinate, i32> altitude_samples;
}