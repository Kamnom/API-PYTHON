PGDMP     "                	    x           RecursosHumanos    13.0    13.0     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16394    RecursosHumanos    DATABASE     m   CREATE DATABASE "RecursosHumanos" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Spanish_Spain.1252';
 !   DROP DATABASE "RecursosHumanos";
                postgres    false            �            1259    16405    personal    TABLE     �   CREATE TABLE public.personal (
    personal_id integer NOT NULL,
    nombre character varying(25),
    apellidop character varying(25),
    apellidom character varying(25),
    fecha_nac date,
    puesto character varying(50)
);
    DROP TABLE public.personal;
       public         heap    postgres    false            �            1259    16403    personal_personal_id_seq    SEQUENCE     �   CREATE SEQUENCE public.personal_personal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.personal_personal_id_seq;
       public          postgres    false    201            �           0    0    personal_personal_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.personal_personal_id_seq OWNED BY public.personal.personal_id;
          public          postgres    false    200            �            1259    16425    usuarios    TABLE     @  CREATE TABLE public.usuarios (
    usuario_id integer NOT NULL,
    usuario character varying(50) NOT NULL,
    "contraseña" character varying(50),
    token_id character varying(255),
    fecha_crea timestamp without time zone,
    ultimo_login timestamp without time zone,
    admin boolean DEFAULT false NOT NULL
);
    DROP TABLE public.usuarios;
       public         heap    postgres    false            �            1259    16423    usuarios_usuario_id_seq    SEQUENCE     �   CREATE SEQUENCE public.usuarios_usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.usuarios_usuario_id_seq;
       public          postgres    false    203            �           0    0    usuarios_usuario_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.usuarios_usuario_id_seq OWNED BY public.usuarios.usuario_id;
          public          postgres    false    202            (           2604    16408    personal personal_id    DEFAULT     |   ALTER TABLE ONLY public.personal ALTER COLUMN personal_id SET DEFAULT nextval('public.personal_personal_id_seq'::regclass);
 C   ALTER TABLE public.personal ALTER COLUMN personal_id DROP DEFAULT;
       public          postgres    false    200    201    201            )           2604    16428    usuarios usuario_id    DEFAULT     z   ALTER TABLE ONLY public.usuarios ALTER COLUMN usuario_id SET DEFAULT nextval('public.usuarios_usuario_id_seq'::regclass);
 B   ALTER TABLE public.usuarios ALTER COLUMN usuario_id DROP DEFAULT;
       public          postgres    false    203    202    203            �          0    16405    personal 
   TABLE DATA           `   COPY public.personal (personal_id, nombre, apellidop, apellidom, fecha_nac, puesto) FROM stdin;
    public          postgres    false    201   �       �          0    16425    usuarios 
   TABLE DATA           q   COPY public.usuarios (usuario_id, usuario, "contraseña", token_id, fecha_crea, ultimo_login, admin) FROM stdin;
    public          postgres    false    203          �           0    0    personal_personal_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.personal_personal_id_seq', 10, true);
          public          postgres    false    200            �           0    0    usuarios_usuario_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.usuarios_usuario_id_seq', 1, true);
          public          postgres    false    202            ,           2606    16410    personal personal_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.personal
    ADD CONSTRAINT personal_pkey PRIMARY KEY (personal_id);
 @   ALTER TABLE ONLY public.personal DROP CONSTRAINT personal_pkey;
       public            postgres    false    201            .           2606    16430    usuarios usuarios_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (usuario_id);
 @   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_pkey;
       public            postgres    false    203            0           2606    16434    usuarios usuarios_token_id_key 
   CONSTRAINT     ]   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_token_id_key UNIQUE (token_id);
 H   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_token_id_key;
       public            postgres    false    203            2           2606    16432    usuarios usuarios_usuario_key 
   CONSTRAINT     [   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_usuario_key UNIQUE (usuario);
 G   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_usuario_key;
       public            postgres    false    203            �   �   x���M
�0���^��D��R-�JB]�숁��$u�[y/fZ�p%���7<	{t���F��-?�@�mG�'��2��*�+�ɣsl�섂���\Жz�ud'-e"���h���X|p�����1F��B���5:�:��9����Ñ�`ۣ!�G��L4�>6���B�7<�U�      �   �   x����n�0 E�ۯ�Fڎ	�f���]�&&TE
	lj�zq�{Xr^�͹�|h�� �w1(m�J����8��5��P=�f7����a����iϴ�$�-�ŭH�H?]b����.���ʔ�i�\�����a�f?�LN��Xuf�5�y��Uc��j⣨-a"�� ����7Ch�˟�7$���G@^&?�_+xp �w��I�     