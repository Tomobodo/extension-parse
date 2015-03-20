package extension.parse;



class FormatHelper {

    public static function DateToJson(date : Date) : Dynamic {

        var rep = {};
        Reflect.setField(rep,"__type","Date");

        var str = date.toString();
        str = StringTools.replace(str, " ", "T") + ".000Z";

        Reflect.setField(rep,"iso",str);

        return rep;
    }

    public static function StringToDate(date : String) : Date {
        date = StringTools.replace(date, '.', ':');
        date = StringTools.replace(date, 'T', ' ');
        date = date.substr(0, date.length - 5);
        return Date.fromString(date);
    }


}