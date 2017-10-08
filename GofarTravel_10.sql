CREATE TABLE vendedores 
(ID INT PRIMARY KEY NOT NULL,
 nombre VARCHAR2(255) NOT NULL,
 telefono VARCHAR2(255) NOT NULL,
 email VARCHAR2(255)NOT NULL);

CREATE TABLE clientes 
(ID INT PRIMARY KEY NOT NULL,
 nombre VARCHAR2(255) NOT NULL,
 telefono VARCHAR2(255) NOT NULL,
 email VARCHAR2(255)NOT NULL,
 direccion VARCHAR2(255) NOT NULL);
 
CREATE TABLE atributos 
(ID INT PRIMARY KEY NOT NULL,
 codigo VARCHAR2(255) NOT NULL,
 costo NUMBER NOT NULL,
 descripcion VARCHAR2(255)NOT NULL,
 precio NUMBER NOT NULL,
 stock INT NOT NULL);
 
CREATE TABLE vehiculos
(ID INT PRIMARY KEY NOT NULL,
 vin VARCHAR2(255) NOT NULL,
 modelo VARCHAR2(255) NOT NULL,
 anio VARCHAR2(255) NOT NULL,
 nombre VARCHAR2(255) NOT NULL);

CREATE TABLE vehiculos_nuevo
(ID INT PRIMARY KEY NOT NULL,
 costo NUMBER NOT NULL,
 nombre_fabricante VARCHAR2(255) NOT NULL,
 vehiculo_id INT NOT NULL,
 CONSTRAINT fk_vehiculos_vehiculos_nuevo FOREIGN KEY(vehiculo_id) REFERENCES vehiculos(ID));

 CREATE TABLE vehiculos_intercambio
(ID INT PRIMARY KEY NOT NULL,
 valor_comercio NUMBER NOT NULL,
 vehiculo_id INT NOT NULL,
 CONSTRAINT fk_vehiculos_v_intercambio FOREIGN KEY(vehiculo_id) REFERENCES vehiculos(ID));
 
CREATE TABLE facturas
(ID INT PRIMARY KEY NOT NULL,
 vehiculo_id INT NOT NULL,
 vehiculo_intercambio_id INT,
 vendedor_id INT NOT NULL,
 cliente_id INT NOT NULL,
 licencia_matricula VARCHAR2(255) NOT NULL,
 precio_total NUMBER NOT NULL,
 total_impuesto NUMBER NOT NULL,
 CONSTRAINT fk_vehiculos_facturas FOREIGN KEY(vehiculo_id) REFERENCES vehiculos(ID),
 CONSTRAINT fk_v_intercambio_facturas FOREIGN KEY(vehiculo_intercambio_id) REFERENCES vehiculos_intercambio(ID),
 CONSTRAINT fk_vendedores_facturas FOREIGN KEY(vendedor_id) REFERENCES vendedores(ID),
 CONSTRAINT fk_clientes_facturas FOREIGN KEY(cliente_id) REFERENCES clientes(ID));
  
 CREATE TABLE atributos_facturas
(ID INT PRIMARY KEY NOT NULL,
 precio NUMBER NOT NULL,
 factura_id INT NOT NULL,
 atributo_id INT NOT NULL,
 CONSTRAINT fk_f_a_facturas FOREIGN KEY(factura_id) REFERENCES facturas(ID),
 CONSTRAINT fk_f_a_atributos FOREIGN KEY(atributo_id) REFERENCES atributos(ID));
 
 CREATE SEQUENCE vendedore_sequence START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
 CREATE SEQUENCE cliente_sequence START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
 CREATE SEQUENCE atributo_sequence START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
 CREATE SEQUENCE vehiculo_sequence START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE; 
 CREATE SEQUENCE vehiculo_nuevo_sequence START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE; 
 CREATE SEQUENCE vehiculo_intercambio_sequence START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
 CREATE SEQUENCE factura_sequence START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
 CREATE SEQUENCE atributo_factura_sequence START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
 
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'BVA79HTX7VP','Chevrolet','18-01-23','violet');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'BFS43FYD5AL','Citroën','18-04-02','indigo');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'EIR26MYN4VG','Mercedes-Benz','17-08-12','yellow');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'HAJ38WHQ4LR','Infiniti','17-07-17','green');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'NWQ14NKU1BT','General Motors','17-02-28','red');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'OHD18XFJ2UY','Smart','16-12-06','green');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'OUV29ZDY8BP','Daihatsu','17-04-14','orange');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'WYA13GYU6FP','Lexus','16-10-27','orange');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'IOB53XEN5BD','Honda','17-01-04','orange');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'BWU28LEW8EA','Audi','18-05-03','orange');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'REG59SNE2DP','Maruti Suzuki','18-02-28','red');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'IKL09RVX2YO','Mercedes-Benz','18-02-11','blue');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'PMO07PJG3YV','MINI','18-02-02','indigo');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'ZEZ10SZT9ZP','Toyota','18-03-15','indigo');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'TZT71UVY4EF','Renault','17-01-23','blue');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'ROA69CFD2AD','Subaru','18-07-07','green');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'WSM79DHZ1AR','Renault','17-11-25','indigo');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'IFH69OME5QO','Citroën','17-08-08','green');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'PQW98IPL9LX','Jeep','17-06-23','red');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'MGB63QUB5MW','Dodge','18-05-23','indigo');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'RLY44RFX5KG','Isuzu','18-04-01','green');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'YJB25MWU4QA','JLR','17-01-18','violet');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'NYV21KJG6IX','Honda','18-09-12','red');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'NAG91WYN9JQ','JLR','17-03-31','blue');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'GGM99STU9GJ','Daihatsu','17-09-01','violet');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'TNC16MVC0BV','Porsche','18-03-14','violet');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'ZZI62BUE4KK','RAM Trucks','17-02-01','red');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'EJS14YKI4LA','Fiat','18-09-01','blue');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'IJG23YGU2TU','Dodge','17-05-12','violet');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'FCE63PXI7IH','Lincoln','17-03-11','violet');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'DSI73IGL2YQ','Peugeot','18-09-09','violet');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'YQV15MUC4LF','Porsche','18-01-27','red');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'ONG04HKB4JK','RAM Trucks','17-01-08','blue');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'HHB51ICT1JN','Kenworth','17-10-08','red');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'TXY55LIY1JL','Daihatsu','17-07-22','orange');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'SWY48UYK9WH','Dodge','17-06-16','red');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'CYG34EQW7WO','Chrysler','17-10-17','indigo');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'SCT21XXK3MZ','Suzuki','18-03-02','green');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'JYG94THN6NJ','Tata Motors','17-03-27','blue');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'TYY48LZI3VC','Porsche','18-01-26','blue');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'YCD29WNR7DB','Citroën','18-02-01','indigo');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'XTG08FAY6UT','Chrysler','17-09-16','orange');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'JUV16KVD8DN','Porsche','17-12-05','indigo');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'DBX72KGC4OF','Fiat','17-11-28','red');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'ZAQ93PBF5MH','Kia Motors','18-05-26','violet');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'LWM34OXQ2ZM','Peugeot','18-01-23','violet');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'SEX70JHV8CN','Lincoln','18-09-29','yellow');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'UIK53SDC0LE','Porsche','17-04-30','yellow');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'JDA55TGG7BB','Vauxhall','17-03-24','violet');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'XAF67WID2DV','Peugeot','17-01-05','blue');
INSERT INTO vehiculos  VALUES (vehiculo_sequence.NEXTVAL,'EFG01SUC6PP','Porsche','17-05-17','violet');

INSERT INTO clientes   VALUES (cliente_sequence.NEXTVAL,'Gavin Decker','(692) 985-3734','Duis.mi.enim@pretium.net','211-3771 Nisl Av.');
INSERT INTO clientes   VALUES (cliente_sequence.NEXTVAL,'Cole Emerson','(329) 374-6031','arcu@molestiesodales.co.uk','P.O. Box 563, 7126 Est, St.');
INSERT INTO clientes   VALUES (cliente_sequence.NEXTVAL,'Dante Vincent','(852) 944-8668','ultricies.ornare.elit@euenim.edu','5478 Accumsan Rd.');
INSERT INTO clientes   VALUES (cliente_sequence.NEXTVAL,'Oliver Hancock','(778) 389-8744','luctus.aliquet.odio@gravida.co.uk','805-9521 Tortor St.');
INSERT INTO clientes   VALUES (cliente_sequence.NEXTVAL,'Ralph Holcomb','(541) 307-8842','id.erat@nonlaciniaat.co.uk','880 Mauris, Rd.');
INSERT INTO clientes   VALUES (cliente_sequence.NEXTVAL,'Tarik Marquez','(375) 348-6631','dui.nec@sociosquadlitora.com','2931 Diam Ave');
INSERT INTO clientes   VALUES (cliente_sequence.NEXTVAL,'Quamar Payne','(501) 267-5901','Vestibulum.ante.ipsum@acmattis.org','Ap #832-2264 Fringilla Street');
INSERT INTO clientes   VALUES (cliente_sequence.NEXTVAL,'Quentin Hurst','(494) 892-5066','convallis@gravida.org','Ap #362-5336 Tellus Street');
INSERT INTO clientes   VALUES (cliente_sequence.NEXTVAL,'Neil Mercer','(761) 554-1240','orci.Donec@Etiamgravida.ca','593-5970 Amet Avenue');
INSERT INTO clientes   VALUES (cliente_sequence.NEXTVAL,'Thor Salazar','(380) 244-2923','In@dignissim.com','P.O. Box 606, 1702 Turpis Road');
INSERT INTO clientes   VALUES (cliente_sequence.NEXTVAL,'Kennan Wilkerson','(181) 749-9467','sodales.elit.erat@commodoipsumSuspendisse.net','119-9608 Auctor Rd.');
INSERT INTO clientes   VALUES (cliente_sequence.NEXTVAL,'Ishmael Knapp','(724) 527-6174','vel@in.org','636-6274 Lobortis Avenue');
INSERT INTO clientes   VALUES (cliente_sequence.NEXTVAL,'Lane Murray','(792) 811-2164','Fusce@massaMaurisvestibulum.com','8088 Orci. Street');
INSERT INTO clientes   VALUES (cliente_sequence.NEXTVAL,'Bradley Gilmore','(638) 307-2890','cursus.purus.Nullam@pellentesqueeget.edu','Ap #551-1611 Aenean Avenue');
INSERT INTO clientes   VALUES (cliente_sequence.NEXTVAL,'Clarke Dodson','(314) 881-9145','Vestibulum.accumsan@atarcu.ca','217-8240 Eros. Rd.');
INSERT INTO clientes   VALUES (cliente_sequence.NEXTVAL,'Ezra Gonzalez','(736) 424-8813','Suspendisse.eleifend@Quisqueimperdiet.co.uk','P.O. Box 266, 1107 Consectetuer Ave');
INSERT INTO clientes   VALUES (cliente_sequence.NEXTVAL,'Clark Pace','(945) 279-7970','tristique.neque.venenatis@augueeutellus.co.uk','931-9674 Sagittis. Road');
INSERT INTO clientes   VALUES (cliente_sequence.NEXTVAL,'Herman Berger','(195) 801-1131','mi.fringilla.mi@Integerid.co.uk','P.O. Box 441, 3890 Dictum Rd.');
INSERT INTO clientes   VALUES (cliente_sequence.NEXTVAL,'Benedict Glover','(149) 868-9460','nascetur@eu.org','767-835 Aliquet St.');
INSERT INTO clientes   VALUES (cliente_sequence.NEXTVAL,'Branden Blankenship','(133) 455-5547','Fusce.dolor@etnetuset.org','106-589 Pede Rd.');

INSERT INTO vendedores  VALUES (vendedore_sequence.NEXTVAL,'Stone Hanson','(361) 670-5880','porta.elit.a@estMauris.net');
INSERT INTO vendedores  VALUES (vendedore_sequence.NEXTVAL,'Price Cox','(702) 892-9716','vestibulum.lorem.sit@Maecenaslibero.org');
INSERT INTO vendedores  VALUES (vendedore_sequence.NEXTVAL,'Kuame Baird','(562) 988-8820','vulputate.posuere.vulputate@eu.co.uk');
INSERT INTO vendedores  VALUES (vendedore_sequence.NEXTVAL,'Adrian Reese','(220) 832-7613','parturient.montes.nascetur@fringillaornareplacerat.com');
INSERT INTO vendedores  VALUES (vendedore_sequence.NEXTVAL,'Tad Clark','(917) 992-4754','at.risus@tellus.ca');
INSERT INTO vendedores  VALUES (vendedore_sequence.NEXTVAL,'Erich Mckee','(954) 311-6069','magna@tortor.com');
INSERT INTO vendedores  VALUES (vendedore_sequence.NEXTVAL,'Lewis Oneal','(464) 833-2734','lobortis.mauris@Vestibulum.net');
INSERT INTO vendedores  VALUES (vendedore_sequence.NEXTVAL,'Hall Hardy','(477) 276-6181','Duis@mi.co.uk');
INSERT INTO vendedores  VALUES (vendedore_sequence.NEXTVAL,'Chester Brooks','(616) 348-3253','et.euismod@lacusUtnec.ca');
INSERT INTO vendedores  VALUES (vendedore_sequence.NEXTVAL,'Garrison Maxwell','(748) 989-6523','augue.ac.ipsum@etnetus.com');

INSERT INTO facturas VALUES (factura_sequence.NEXTVAL,2,NULL,1,23,'60992304995482',47938163,5682393);
INSERT INTO facturas VALUES (factura_sequence.NEXTVAL,3,NULL,2,24,'62238830710998',415269760,7314435);
INSERT INTO facturas VALUES (factura_sequence.NEXTVAL,5,NULL,3,25,'78248016448804',151445402,8463271);
INSERT INTO facturas VALUES (factura_sequence.NEXTVAL,7,NULL,4,26,'83170085793144',845072564,4363485);
INSERT INTO facturas VALUES (factura_sequence.NEXTVAL,9,NULL,5,27,'36723149531132',374235810,4109209);
INSERT INTO facturas VALUES (factura_sequence.NEXTVAL,11,NULL,6,28,'94727602445954',218686297,6392182);
INSERT INTO facturas VALUES (factura_sequence.NEXTVAL,13,NULL,7,29,'56241480964316',948410537,4379121);
INSERT INTO facturas VALUES (factura_sequence.NEXTVAL,15,NULL,8,30,'75302256231862',830568568,8913639);
INSERT INTO facturas VALUES (factura_sequence.NEXTVAL,17,NULL,9,31,'02623601231726',862328270,8250128);
INSERT INTO facturas VALUES (factura_sequence.NEXTVAL,19,NULL,10,32,'61473677104404',278640881,0364837);
INSERT INTO facturas VALUES (factura_sequence.NEXTVAL,21,NULL,1,33,'98502037381129',270377965,8253629);
INSERT INTO facturas VALUES (factura_sequence.NEXTVAL,23,NULL,2,34,'92200151497735',243691941,3919626);
INSERT INTO facturas VALUES (factura_sequence.NEXTVAL,25,NULL,3,35,'52987033392782',605939018,7036519);
INSERT INTO facturas VALUES (factura_sequence.NEXTVAL,27,NULL,4,36,'02310687475029',515220097,8913818);
INSERT INTO facturas VALUES (factura_sequence.NEXTVAL,29,NULL,5,37,'59772356046789',199910781,1250235);
INSERT INTO facturas VALUES (factura_sequence.NEXTVAL,31,NULL,6,38,'36742281751488',563115267,6499108);
INSERT INTO facturas VALUES (factura_sequence.NEXTVAL,33,NULL,7,39,'97697479366361',348264874,9053422);
INSERT INTO facturas VALUES (factura_sequence.NEXTVAL,35,NULL,8,40,'58756660156017',062286186,2784942);
INSERT INTO facturas VALUES (factura_sequence.NEXTVAL,37,NULL,9,41,'55803579892445',985119480,5699814);
INSERT INTO facturas VALUES (factura_sequence.NEXTVAL,39,NULL,2,42,'97979452368464',538126778,4305477);
INSERT INTO facturas VALUES (factura_sequence.NEXTVAL,41,NULL,5,40,'11974114972217',683277392,3024276);
