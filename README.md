# frames + audio -> music

ya i know theres many implementations of this already,  
yes it uses FFMPEG,  
yes its just a personal project for me that fits my own personal needs.  
and lastly, yes the code is very ass  

# TO USE:  
`FNA2V.py --INFOJSON![FileName].json`  
("[FileName]" should be your json file name)  

# EXAMPLE JSON:  
```json
{
    "frameNames": "FRAMENAME", //name of each frame, examp: ["FRAMENAME.png", "FRAMENAME.png"]
    "frameFormat": "png", //file format of each frame.
    "frame0sAmt": 8, //the amount of zeros before the number, examp: 8 = ["FRAMENAME000000001.png", FRAMENAME000000002.png]
    "fps": 15, //how many frames per second, duh.
    "audioName": "woa.wav", //the file name of ur audio.
    "folder": "testing", //the folder this is all in.
    "outFile": "out.mp4" //the out file of all this, usually u want it in a format WITH video, i guess
}
```
## that example can be found [here](example.json)