import haxe.Json;
import sys.FileSystem;
import sys.io.File;

using StringTools;

class JsonType {
    public var frameNames:Null<String>;
    public var fps:Null<Int>;
    public var audioName:Null<String>;
    public var folder:Null<String>;
    public var frame0sAmt:Null<Int>;
    public var frameFormat:Null<String>;
    public var outFile:Null<String>;
}

class Main{
    static var argEnd:Map<String, String> = new Map<String, String>();


    public static function checkAndYell(thing:Dynamic, name:String){
        if(thing == null){
            throw(name + " IS NULL!! it cannot be!!");
        }
    }
    public static function main(){
        var args = Sys.args();
        for(arg in args){
            var argSplitted = arg.split("!");
            if(argSplitted.length > 1){
                var argFirst = argSplitted[0];
                argFirst = argFirst.substring(2, argFirst.length);
                argSplitted.remove(argSplitted[0]);

                trace(argFirst);
                argEnd[argFirst] = argSplitted.join("!");
            }
        }

        //whatever it can be better but i just dont fuckin care -.-
        if(args[0] == "help" || args[0] == "-help" || args[0] == "--help" || args.length == 0){
            Sys.println("TO USE:");
            Sys.println("python FNA2V.py --INFOJSON![FileName].json");
            Sys.println("(replace \"[FileName]\" with the name of ur .json file)");

            return;
        }

        if(!argEnd.exists("INFOJSON")){
            throw("no infojson!");
        }
        
        var jsonpath = "./" + argEnd.get("INFOJSON");
        if(FileSystem.exists(jsonpath)){
            var theJson = File.getContent(jsonpath);
            var cookedJson:JsonType = Json.parse(theJson);

            var shouldDOTDOTout = false;
            if(cookedJson.folder != null){
                Sys.setCwd(cookedJson.folder);
                shouldDOTDOTout = true;
                trace(Sys.getCwd());
            }

            checkAndYell(cookedJson, "cookedJson");
            checkAndYell(cookedJson.frameNames, "frameNames");
            checkAndYell(cookedJson.fps, "fps");
            checkAndYell(cookedJson.audioName, "audioName");
            checkAndYell(cookedJson.frame0sAmt, "frame0sAmt");
            checkAndYell(cookedJson.frameFormat, "frameFormat");
            checkAndYell(cookedJson.folder, "folder");
            checkAndYell(cookedJson.outFile, "outFile");

            if(FileSystem.exists("./" + cookedJson.outFile)){
                FileSystem.deleteFile("./" + cookedJson.outFile);
            }
            var finalFrameNameStuff:String = cookedJson.frameNames + "%0" + Std.string(cookedJson.frame0sAmt) + "d." + cookedJson.frameFormat;

            var args = ["-framerate", Std.string(cookedJson.fps), "-i", finalFrameNameStuff, "-c:v", "libx264",  "-pix_fmt", "yuv420p", "-c:a", "aac"];
            if(cookedJson.outFile.endsWith(".mp4")){
                args.push("-i");
                args.push(cookedJson.audioName);
            }
            //if  "-i", cookedJson.audioName

            args.push(cookedJson.outFile);

            Sys.command("ffmpeg", args);
            if(shouldDOTDOTout){
                Sys.setCwd("../");
            }
        }else{
            throw("json dont exist!");
        }
    }
}