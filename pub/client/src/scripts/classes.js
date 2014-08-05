var TestData;

TestData = (function() {
  function TestData(name, tags, attributes, execTime, runDate, suite) {
    this.name = name;
    this.tags = tags;
    this.attributes = attributes;
    this.execTime = execTime;
    this.runDate = runDate;
    this.suite = suite;
  }

  return TestData;

})();
