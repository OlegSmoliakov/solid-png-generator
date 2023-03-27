# Solid-png-generator

Script helps to create a lot of solid png backgrounds   

You can change image names and loop parameters in `main.bat` via any text editor


Main comand: 
`magick convert -size %resolution% xc:#%HEX%%HEX%%HEX% %out_x%_%out_x%_%out_x%.png`

You can change:
- Resolution
- RGB color (after `xc:`) if you change it manualy, use HEX values
- The names of the images to be created (I use decimal color values separated by `_`)

The color depends on the order and value of the 3 HEX numbers after `xc:`

By default you should use **decimal** values for colors


## Installation and use

 1. First of all, you need to install **[ImageMagick](https://imagemagick.org/script/download.php)** on your PC
 2. Start `main.bat`
    ## Example color format 

| Color   | Decimal code (R, G, B) | Hex #RRGGBB |
|---------|-------------------|-----|
| Spring green | (0, 255, 127) |![#00FF7F](https://via.placeholder.com/20/00FF7F?text=+) #00FF7F |
| Sienna | (160, 82, 45) |![#A0522D](https://via.placeholder.com/20/A0522D?text=+) #A0522D |
| Lemon chiffon | (255,250,205) |![#FFFACD](https://via.placeholder.com/20/FFFACD?text=+) #FFFACD |

