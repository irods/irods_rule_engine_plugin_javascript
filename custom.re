# iRODS Rule Language - custom.re

irodsFunc1(*foo) {
    writeLine("serverLog", "custom.re - BEGIN - irodsFunc1(foo): [*foo]");
    jsFunc1("called from custom.re");
    writeLine("serverLog", "custom.re - END   - irodsFunc1(foo)");
}
