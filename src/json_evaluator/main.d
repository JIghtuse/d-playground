import std.array, std.json, std.path, std.stdio;

enum homeRulesFilename = "home_rules.json";

string buildHomePath(JSONValue jsonStringArray, string user) {
    string[] pathParts;
    foreach (size_t i, value; jsonStringArray) {
        if (value.str == "$username") {
            pathParts ~= user;
        } else {
            pathParts ~= value.str;
        }
    }
    return buildPath(pathParts);
}

string[string] LoadHomeRules(string user) {
    JSONValue homeRules = parseJSON(import(homeRulesFilename));
    
    string[string] rules;
    foreach (string key, value; homeRules) {
        rules[key] = buildHomePath(value, user);
    }
    return rules;
}


void main() {
    enum os = "Linux";
    enum homeRules = LoadHomeRules("noone");
    enum homePath = homeRules[os];
    
    writefln("Home path: %s", homePath);
}
