PGDMP  	                     }            BDA_TP1    17.4    17.4     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            �           1262    16388    BDA_TP1    DATABASE     �   CREATE DATABASE "BDA_TP1" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE "BDA_TP1";
                     postgres    false            �          0    16402    Persona 
   TABLE DATA           �   COPY public."Persona" ("Id", "Nombre", "Apellido", "DNI", "Fecha_Nacimiento", "Fecha_Registro", "Fecha_Creacion", "Fecha_Modificacion") FROM stdin;
    public               postgres    false    220   �       �          0    16412 	   Direccion 
   TABLE DATA           �   COPY public."Direccion" ("Id", "Calle", "Numero", "Ciudad", "CP", "Id_Persona", "Fecha_Creacion", "Fecha_Modifiicacion") FROM stdin;
    public               postgres    false    222   "       �          0    16552    Direccion_Historial 
   TABLE DATA           �   COPY public."Direccion_Historial" ("Id", "Calle", "Numero", "Ciudad", "CP", "Id_Persona", "Fecha_Creacion", "Fecha_Modificacion") FROM stdin;
    public               postgres    false    231   �       �          0    16396    Libro 
   TABLE DATA           �   COPY public."Libro" ("Id", "ISBN", "Titulo", "Editorial", "Anio_publicacion", "Estado", "Autor", "Fecha_Creacion", "Fecha_Modificacion") FROM stdin;
    public               postgres    false    218   �       �          0    16557    Libro_Historial 
   TABLE DATA           �   COPY public."Libro_Historial" ("Id", "ISBN", "Titulo", "Editorial", "Anio_Publicacion", "Estado", "Autor", "Fecha_Creacion", "Fecha_Modificacion") FROM stdin;
    public               postgres    false    232   
'       �          0    16528    Multa 
   TABLE DATA           �   COPY public."Multa" ("Id", "Id_Prestamo", "Monto", "Fecha_Generacion", "Fecha_Pago", "Estado", "Fecha_Creacion", "Fecha_Modificacion") FROM stdin;
    public               postgres    false    230   .       �          0    16560    Multa_Historial 
   TABLE DATA           �   COPY public."Multa_Historial" ("Id", "Id_Prestamo", "Monto", "Fecha_Generacion", "Fecha_Pago", "Estado", "Fecha_Creacion", "Fecha_Modificacion") FROM stdin;
    public               postgres    false    233   k.       �          0    16563    Persona_Historial 
   TABLE DATA           �   COPY public."Persona_Historial" ("Id", "Nombre", "Apellido", "DNI", "Fecha_Nacimiento", "Fecha_Registro", "Fecha_Creacion", "Fecha_Modificacion") FROM stdin;
    public               postgres    false    234   �.       �          0    16440    Usuario 
   TABLE DATA           �   COPY public."Usuario" ("Id", "Estado", "Id_Persona", "Tipo", "Libros_Prestados", "Fecha_Creacion", "Fecha_Modificacion") FROM stdin;
    public               postgres    false    224   /       �          0    16502    Prestamo 
   TABLE DATA           �   COPY public."Prestamo" ("Id", "Id_Usuario", "Id_Libro", "Fecha_Prestamo", "Fecha_Devolucion_Estimada", "Estado", "Fecha_Creacion", "Fecha_Modificacion", "Fecha_Devolucion_Real") FROM stdin;
    public               postgres    false    228   �/       �          0    16569    Prestamo_Historial 
   TABLE DATA           �   COPY public."Prestamo_Historial" ("Id", "Id_Usuario", "Id_Libro", "Fecha_Prestamo", "Fecha_Devolucion", "Estado", "Fecha_Creacion", "Fecha_Modificacion", "Fecha_Devolucion_Real") FROM stdin;
    public               postgres    false    235   �1       �          0    16484    Reserva 
   TABLE DATA           �   COPY public."Reserva" ("Id", "Id_Usuario", "Id_Libro", "Fecha_Reserva", "Fecha_Vencimiento", "Estado", "Fecha_Creacion", "Fecha_Modificacion") FROM stdin;
    public               postgres    false    226   �2       �          0    16572    Reserva_Historial 
   TABLE DATA           �   COPY public."Reserva_Historial" ("Id", "Id_Usuario", "Id_Libro", "Fecha_Reserva", "Fecha_Vencimiento", "Estado", "Fecha_Creacion", "Fecha_Modificacion") FROM stdin;
    public               postgres    false    236   n3       �          0    16578    Usuario_Historial 
   TABLE DATA           �   COPY public."Usuario_Historial" ("Id", "Estado", "Id_Persona", "Tipo", "Libros_Prestado", "Fecha_Creacion", "Fecha_Modificacion") FROM stdin;
    public               postgres    false    237   �4       �           0    0    Direcciones_Id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public."Direcciones_Id_seq"', 10, true);
          public               postgres    false    221            �           0    0    Libro_Id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public."Libro_Id_seq"', 131, true);
          public               postgres    false    217            �           0    0    Multas_Id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public."Multas_Id_seq"', 1, true);
          public               postgres    false    229            �           0    0    Prestamo_Id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public."Prestamo_Id_seq"', 68, true);
          public               postgres    false    227            �           0    0    Reserva_Id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public."Reserva_Id_seq"', 50, true);
          public               postgres    false    225            �           0    0    persona_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.persona_id_seq', 10, true);
          public               postgres    false    219            �           0    0    usuario_Id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public."usuario_Id_seq"', 10, true);
          public               postgres    false    223            �   P  x��ҽn�0������?��aCET�hUAGR�ve����؁�G���F�Y����YëO���9����)mU�T㬐����F(-��#~�BɁ�#]��*�m,�
�n{�y\#��cMb��B"��(/G�Õ0�m
�7�QcLa���0�5-t�f�ɧ]<���r�i�;�e������	�,�����ާv=T�m�����|
������c��*y��p���ڰ�z���7z�Y�G���r<%t_��-��>�z�U��u�4.��]+^X�Ozs1�� W��p48NtY�����a0N{�q��=�QB6��Z~�]���3˳�      �   O  x���;n1E�7��@���C��)1Q*�v#c3��I��%���DJ��O>G�ח��I;��tF�A�7sB`\@w�}�m0J)0����#F	J'����k`�(8L�ZMfh������vs>�8�lT��B���>aPd�]�BݴQ|0=Z2�J��H2����z$-Ȫ��?b0�D�R�������N�c��kP~� �Df$U�zo�'+7��\;�/U«^����]Qڒg�=!�u��۷�:iꌦ���$鼅�,a��~^Z��$j2����9�} )%th#�&����	�)�X��9�D������ۏ�,6�f<�qQ��ܪ~      �      x������ � �      �   \
  x��YKs�8>3��9-]��͖_���ky�5[s�IHBL*�����@�9bJ3�T��*v���G�Y�dI�znHC��� pC�BI��Z�+Ý+�d.�\����\�ʡ�9�Z*)�g,f5/�F\�2i���#׋\��z�i�dAz����OY�	d��0���9�앓���<)]��K�����,�1��B����K��F=��t�q�ɹVf�uEn�f�C�6?~��J0IƼ���q��4���V�P�\��(�Z��@�h�&q�n�Ě̅r���xp�V8j�tcM_ι$��cCa������i��~�0wJDM���Ã*T��C� ��oB"hv�~9y�����`�`6
1F^R7j�ި�ga�k�􌓟C����7�� q�:dm;F��c8��d�9���&�꥽��?���\U�B�-�����EQ��3V�J��� ��N���G���� ��<ady�ɑfo+*2��q_�6d���|{�.�%si�{�R�ȝ0��	����5�hod� N�J��0 �N%� L�ͤ��r��v���\���iY7�-3s��dbPyn�`��n��w#���z�H��&m�/�o�0Y�3�%���2�Y�B�
���I������qs��b67�F����v�]jla#+�� �`�0L�&�r�Pe�/Y�v��Y�V�;���Z�8�-�$P��>P���e��G�����ȟL�������,C��S/N��_�^���s���T3�|�yV�+���jA��Fn�`�5�]���
��OM�����G$58�4�`=�Kc��*�L �18!c<ܱc�^Uo� �H��J6w�4�/�,ˆ^�Q}��Yʐ	G�ϲ��>�Ϥ�+��&r=����5X��4�6���$�s��έT˩�~�l0���_]���(i����4l�m��ad'*'�|dGix\ZrI ~�k!�bui:�֠*��ژ.�z�拚Kr�����^W���6f�V�^��σx�z�Y�#��d��1Od0&��B(�Zf0�d!�M�� x�w��4�cq���Ⲩsfx�< �Z�au����1�0|��0i��f,a]�&a[�ϋ�҆��VՃ@/�h^*�0���Bw�����~�b�;�ˮ���d�L��R�j0Xk\0�D�@(;�*8�'�_'fީr��l�V�p{��%�����Ñ[�G���4m��AU����w�g"�zC8��
��^k�V��P��M�d
�Pgl���OU;�p�%_���w�*�����q�ę�ᚑ��5����b�y&PAA�ؒ�A1�[���i�0�Zڹ�$(�%�G�0��`��DŠo/��H�é����ė�۳�d�\7�#�U��r�^���h-렃n�yqj�I����i����4/�x!�,A�B�m=i�A䥰Ψ��t�
I�=��Vb�FX�50S�b���Zi>��+?8��SJO���S�nS�FIdg�{e�d=H�<���u�o�hR�oS���	peq�{lE��z���$ �,��n�t�"#,]�~��l��k��aw^ �{%��|�d���c9;6�lg�Ck˒`��ټ�aέ�Թ�q�s��_��A7���/�#@�q/��%�5�PJ�'�A��`NCg±�ػ�'��k=�yd�<6��7�ƛJ|����ЮΣ��.0�YJ��noRڕ�f����-�����a=##frl��5��C�͢δ|9�8A����h�+��'n�����{]`Z��r�00fMigZ��}�̪��!������ȧA����y̐kf��l��c���
|��>A���\� �2�\	�鲲82�xG3��Џ��,�V0TFX�P䬜a�7�E�??�.O:C�`�9!�1�f��Y/iq�1�/x%f�.�v�������.���B4�:\�U9����A�<��0o�F��ù�N!g�Nb9���U�kF�K�\���Ж3��T�.:�������3�SC��K��e��	:لq�t�̿ߞ�x�� ��#C�<B{� d������Iv�ךL�����͡�=!\y�2s��=c&ݱ��_��c�KkvT*�+� ,�Y0+���2j�l��A� ��PlBnem������!Fަ>�n��rV۝�?�(Q'�sm��-p�=�o;�Qڥ�`M+��m}�3�V�����]q@�����q��qO����Y�}�D�?�-�� Ck}Ϫ�^��\�^�R�
��\���F
�4�֚�����Y��[���#a
��	ػ���;��F�K&��&{L��X��vϏ.��k^�YJ~R�+���rEޠ��P3��~�-�ݬ��Ur`_>�\��YjI��HP^�׺yI�V���œ\��Ûߡ<v�����n�WBWf-����7�c^�S��m�
{=ׇ�����s�A�Ӎ +{!I��=3����V�����j��
9pQ|(�-Ag��<Ԛ&���M�Z-�۳y?��k+0'׺>�7�-������d�_bX�n��uw4ޅ�v�V�����+�c�g���hC��lc��r/D��{�۾���Xb�k��վs9ք',���<������q���qe�MVF�.�u��ӧ���HQ      �   �  x��XMS�8<�_�Ӝ�.˖e+7_d���2�(�Ǣd6����	�x�@�b�� �^���;�����vm�c�>������Ƌ�H�"��q2UZ��<�F_ЭYfy�ˬS�=�T>&�z��9�Х��J�E
�����a>%�o�������h�X}����8�c.��=�'y�>���8�?p�s0���:���9���t�x��%�C��}����p�u"�(�|~�8������z���#B��iz�@ls ��7�lb�Sx�X�I����I�"*�N=
m��A#��lS��]�y.�)�)�]�Tdr��[n��if��2S��]d�XZ�1R�<�2��>��64�)��4
��u6� �E�+��߃��*�]�l���$Q�ͫ��1�2���	�&�$�S��5��e�{� 6��"�D��/��>����9��Oj��0�kȭ�q:��].R�Kְ����'�의�����f�2�j^йzM�X-XA	+�Kl�(q�43�#��#���v���%�s-��D+�����8%�f>f�MP�)R؎��&v�nMј��8���'ct�.L�8�����#�]�<,��N|�~���
�����װ_r:�k���_�i�Eщ0�>k�����N�:�VlU��0ì:���)�������P��-���Zo����U?k�Aß���B��u<�d������gG<z�*§HD�\=�2�,32�c�6O��6�i��ږ�T}$��v�Z��*ԇ,���J?�x�L��	݈)���pRŏg\$�\p3�mۢ7cQ.'�`]�\�����h�5����������!
� w�K���\�̬��۝�	?cɷ8��Җ�^
�ۼ(z����P��-�nA�`�&J�Sn8:uXf2ۂ�J'T�u-a��m�c0��J�y�u�܉�D�9�������f��ЋVf�5(� �M�./�a|�.f�k0-�|�}�Pj<�P�mHQ��ẇy��P��Z!�%�����ڗr%!����А{X�d�f��2%�k��Z�9�e�V#�����Hc�\�e^r��r�9���xF�T P�{�0c���x�m�؛H�ķ��(1f�I�"~+���s�����,.��S����v7`o�D��>`���!�F*���Q�q^'�{� X�ݺ��Oa�D��Uت��|-� �b�n)���!�5-93��nT�z�:�/mڪ��Tj�0��GZB�
������zp��Ψ���t��CK��i�a�@�x����B�\C�6���θN@k@�c
��U��W�TPd���4��� ��Ӎ���\�H=.�S?���KN��;pTe6u:1��Dkw�naPW̊|A���-��B�.Z�#Z��ЃJ2�Zuwa�|��,������A�9����I�3�wO�D>�����n8�Q@��9��70��̗8���7ԝ�4��AGڐ��51r ;l�}/��)/;�d���&F~��o���ě�6^41�����BG;��>ML��6�|05Q�aNk��S��hvMoM�0D6q�W��p�c�l���)�)���Y�/��?a�Wy��9�/~�3��-���&Ŀ�"�����5`��g�A��_CT��Ц����5D��8gO����0rHۮ���k�
ŇFztQa�'������!*�t�j���5D��>������p�E���k�
]�ߚ\�'f;����^噞戾�uϼ�G��3G��B��9::����      �   I   x�Mɱ�0�ڞ��0 � �%$�߀6��2&(�6o{꫷�x�����Z�+1:b�>�����      �   B   x�3�44�440�4202�50�54����H�K�L�+IEW04�22�25�302442������ �	�      �   L   x�3��*M��8��(���������܂����@��T�Ѐ����D��P�Д3����Z�r�R�I����� ��]      �   �   x���1
�0@�Y>E/#�R�x+�kO�%$<4����[
*�oF�vpK~��ຕ}��Rf@ $iP�'r�9Y��)@3^��1���>��Ur�=Q%pY��i����Ae�I�����NIW����mXI��X���'z�������Q�^      �     x��WAn$!<�_�a��Ҟ��V9���^�y����L�����U�TU�D�<�G�_?�|y�������o���P�|lJ����(��O���>���8Qm	KD�	�肯�4�7�GvIBjK�����|m�)m��}���^�}e��1�����_$ߢH���(	�_E!��p0ɻQ2$Z�K� �W;��V;PHq%�@�չ(�V�Mv�#�](���#�]-1��#�]�e;hЎx�uTū���*^]/W��xYLv�ﾎl������E��*^�U0��K�%�󬂩-Y��S�Mi�HG�g��tϣt?����c��tN�e�O���~��b��D^S3��O���<��y�0�ބ'�^�'���D�����b��|�v5�Z���馴ũ�:�w*���
�x�� ީ�:�w*���
�x�� ޹�:��,�8`��4������7a��Ӥ��9�6L�c{P�h�|���QZ������Jk¹鶖��Kk�9��O��m��C�      �   �   x���1jC1���{��b,Y�-o�@O��S�,���+�B zCd�`�a促a\Y/U/T��ׯ������t��ƅ̸*n��ڈO��b��R�u�WƉ�c��O�V��Js(�J�Z�r�m�C����*������0N�t9���A���۪��\V�khp]�K��mU�/z_L"�1E�����h"�@I�(�x%o�$��D����7P�J&�W�V�m�"�C�      �      x���11D�zr
.��؉�x[�A���J �p����
w#���ÜP�UZyO�B����m߮�D�ԕmq!��H�+3��G0	��$ᆃ�$|@-	wL|]��O4�%၁9���_�R��T��      �     x���=j1��Zs���ɶƖ�\ '�&l�}������J2L1`�)��7BJ�S�'�)���N6zy�??���r5�W-bt=2e�#jd�#T22����w������:Y�:2��.�kG�����VS��RyhN\�%��w��0�_�B��\��s!�u.�?O$J O4*�)�Ԑ���<��&����3@`���g��<� 0� �y�	]��%��}TM����/9��H���z"XO$�D`=��'���F��{:�����      �   �   x���;�0D��)�@V���'ih�%.�$HΏK�4A�)��it���貎u�*	A:	��	Z�
���h�:�����e��õ
�I�������e��t��D��/&�(�ǟ�5];X|Kv;��;R#     