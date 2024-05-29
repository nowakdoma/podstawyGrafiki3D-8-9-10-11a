#version 330

in vec4 iC;
in vec4 lfarg;
in vec4 nfarg;
in vec4 vfarg;
in vec2 iTexCoord0;


out vec4 pixelColor; // Zmienna wyjsciowa fragment shadera. Zapisuje sie do niej ostateczny (prawie) kolor piksela

uniform sampler2D textureMap0;
uniform sampler2D textureMap1;


void main(void) {
    vec4 n = normalize(nfarg);
    vec4 l = normalize(lfarg);
    vec4 v = normalize(vfarg);

    float nl = max(dot(n, l), 0.0);

    vec4 La = vec4(0.0, 0.0, 0.0, 1.0);
    vec4 Ld = vec4(1.0, 1.0, 1.0, 1.0);

    vec4 r = normalize(reflect(-l, n));

    float rv = max(dot(r, v), 0.0);
    rv = pow(rv, 25.0);

    vec4 texColor = texture(textureMap0, iTexCoord0);

    vec4 kd = texColor;
    vec4 ks = texture(textureMap1, iTexCoord0);

    vec4 Ls = vec4(1.0, 1.0, 1.0, 1.0);

    // Finalny kolor piksela
    pixelColor = (Ld * kd * nl) + (Ls * ks * rv);
}
