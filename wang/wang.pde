final int N = 50;
final int R = 3;
final float VEL = 2.0;

PVector[] pos;
color[] clr;
PVector[] vel;

color closestPtColor(PVector pixel, PVector[] pos, color[] clr)
{
    float minDist = PVector.dist(pixel, pos[0]);
    int closestPtIdx = 0;

    if (N == 1) {
        return clr[0];
    }

    for (int i = 1; i < N; i++) {
        float dist = PVector.dist(pixel, pos[i]);
        if (dist < minDist) {
            minDist = dist;
            closestPtIdx = i;
        }
    }

    return clr[closestPtIdx];
}

void setup()
{
    assert N > 0;

    size(800, 600);

    pos = new PVector[N];
    vel = new PVector[N];
    for (int i = 0; i < N; i++) {
        pos[i] = new PVector(random(width), random(height));
        vel[i] = new PVector(random(-VEL, VEL), random(-VEL, VEL));
    }

    clr = new color[N];
    for (int i = 0; i < N; i++) {
        clr[i] = color(random(256), random(256), random(256));
    }
}

void draw()
{
    for (int i = 0; i < N; i++) {
        if (pos[i].x < 0 || pos[i].x > width) {
            vel[i].x *= -1;
        }
        if (pos[i].y < 0 || pos[i].y > height) {
            vel[i].y *= -1;
        }
        pos[i].add(vel[i]);
    }

    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            color col = closestPtColor(new PVector(x, y), pos, clr);
            set(x, y, col);
        }
    }
}
