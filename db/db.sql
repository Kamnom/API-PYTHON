PGDMP     .    %            	    x           RecursosHumanos    13.0    13.0     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16394    RecursosHumanos    DATABASE     m   CREATE DATABASE "RecursosHumanos" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Spanish_Spain.1252';
 !   DROP DATABASE "RecursosHumanos";
                postgres    false            �          0    16405    personal 
   TABLE DATA           `   COPY public.personal (personal_id, nombre, apellidop, apellidom, fecha_nac, puesto) FROM stdin;
    public          postgres    false    201   �       �          0    16425    usuarios 
   TABLE DATA           q   COPY public.usuarios (usuario_id, usuario, "contraseña", token_id, fecha_crea, ultimo_login, admin) FROM stdin;
    public          postgres    false    203   �       �           0    0    personal_personal_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.personal_personal_id_seq', 10, true);
          public          postgres    false    200            �           0    0    usuarios_usuario_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.usuarios_usuario_id_seq', 1, true);
          public          postgres    false    202            �   �   x���M
�0���^��D��R-�JB]�숁��$u�[y/fZ�p%���7<	{t���F��-?�@�mG�'��2��*�+�ɣsl�섂���\Жz�ud'-e"���h���X|p�����1F��B���5:�:��9����Ñ�`ۣ!�G��L4�>6���B�7<�U�      �   �   x����n�0 E�ۯ�Fڎ	�f���]�&&TE
	lj�zq�{Xr^�͹�|h�� �w1(m�J����8��5��P=�f7����a����iϴ�$�-�ŭH�H?]b����.���ʔ�i�\�����a�f?�LN��Xuf�5�y��Uc��j⣨-a"�� ����7Ch�˟�7$���G@^&?�_+xp �w��I�     