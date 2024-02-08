CREATE TABLE public.layer1 (
    id serial PRIMARY KEY,
    name varchar(255),
    geom geometry(Point, 4326)
);

INSERT INTO public.layer1 (name, geom)
VALUES (
    'Sample Point - Florianópolis',
    ST_GeomFromText('POINT(-48.564151 -27.593550)', 4326)
);

