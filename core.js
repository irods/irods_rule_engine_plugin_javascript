/* Javascript - core.js */

function jsFunc1(foo, callback) {
    callback.writeLine("serverLog", "JAVASCRIPT - BEGIN - jsFunc1(foo, callback)");
    callback.writeLine("serverLog", "  - with parameter foo[" + foo + "]");
    try {
        callback.doesnotexist();
    } catch(e) {
        throw e + " -- ERROR HANDLING FTW!";
    }
    callback.writeLine("serverLog", "JAVASCRIPT - END   - jsFunc1(foo, callback)");
}

function acPostProcForPut(callback) {
    callback.writeLine("serverLog", "JAVASCRIPT - BEGIN - acPostProcForPut()");
    callback.irodsFunc1();
    callback.writeLine("serverLog", "JAVASCRIPT - END   - acPostProcForPut()");
}
