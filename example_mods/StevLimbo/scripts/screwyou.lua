--By SobGuy, please credit me :3
function onCreatePost() 
if checkFileExists ('data/'..songPath..'/screwyou.txt') then
    makeLuaText('MessageUp', getTextFromFile ('data/'..songPath..'/screwYou.txt'), 0, 0, 0)
    setTextColor('MessageUp', 'FFFFFF')
setTextFont('MessageUp', 'comic.ttf') --change the font to whatever you want, it must include .ttf at the end
setTextSize('MessageUp', 16)
    addLuaText('MessageUp', getTextFromFile ('data/'..songPath..'/screwYou.txt'), 0, 0, 0)
end
end