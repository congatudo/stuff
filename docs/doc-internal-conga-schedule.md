# Manipulate schedule

After switching outside the Conga Cloud, you may find that sometimes your Conga start cleaning without even asking for it. This is probably happen because of the old schedule configured from the app, that is remaining inside the Conga.

One possible solution for disabling it is deactivating Valetudo/Congatudo and turning off the schedulo from the mobile app itself. However, you can also do it directly modifying the config files of the Conga.

The file itself is located in `/mnt/UDISK/config/booking_list_config.ini`. You can access to it through SSH ([check docs](https://github.com/freeconga/stuff/blob/master/docs/rooting-conga.md)).

A example of a valid config (from Conga 4090 in this case):

```
[Booking_Size]
size=1


[order_task_0]
order_enable=1
order_id=1588517833
clean_flag=0
weekday=36
repeat=1
daytime=1140
mapid=1611924380
planid=1
cleanmode=1
windpower=2
waterlevel=12
twiceclean=0
room_id_list_size=0
```

This example contains only one schedule, which is controled with the flag `order_enable`. If you want to disable all schedule, change all `order_enable=1` to `order_enable=0`



---

Extra docs about the config (sorry, I'm lazy to translate it :P):

```
Pequeña docu:


[Booking_Size]
# Total de programaciones instaladas
size=1

# El numerito va al revés de lo que se muestra en la app. Es decir, de 0 a n desde abajo hacia arriba
[order_task_0]

# 1 = activado, 0 = desactivado
order_enable=1

#random?
order_id=1588517833

clean_flag=0

# de lunes a domingo en potencias de 2, haciendo suma. D=1, L=2, M=4, X=8, J=16, V=32, S=64
# Ej: Lunes y miercoles : 2+8 = 10
weekday=36

repeat=1

# Hora del arranque, segundos desde las 00 (24h en total)
daytime=1140

# Mapa. No sé de donde viene el valor
mapid=1611924380

# Plan. 1= Limpieza completa, 2= Default (wtf?). No sé si hay mas
planid=1

# Modo. 1= Auto, 3 = Bordes, 4 = Fregado
cleanmode=1

# Potencia de succión. 0=OFF, 1=Eco, 2=Normal, 3=Turbo
windpower=2

# Nivel de agua. 10=OFF, 11=Baja, 12=Medio, 13=Alta
waterlevel=12

# Modo twice, 1=ON, 0=OFF
twiceclean=0

room_id_list_size=0
```
