1. 下载csv

```
function copyTableDate(){
  const tabledata = JSON.parse(JSON.stringify(this.state.CnTable.__tableData__));
  const headers = {
    "id": "异常id",
    "msgContent": "消息原文",
    "msgId": "消息id",
    "riskName": "异常名称",
    "bizLineNamePath": "业务线",
    "groupName": "归属钉群",
    "statusDesc": "状态",
    "riskLevelDesc": "级别",
    "gmtCreateMills": "创建时间",
    "finishTimeMillis": "完结时间",
    "userName": "商家账号",
    "owners": "责任人"
};
  const keys = Object.keys(headers);
  const headerValues = Object.values(headers);
  const csvRows = [];
  csvRows.push(headerValues.join(','));
  for (const row of tabledata) {
    const values = keys.map(key => {
      let val = row[key];
      if (val === null || val === undefined) {
        val = '--';
      } else {
        if (key === "gmtCreateMills" || key === "finishTimeMillis"){
          val = convertFormatDate(val);
        } else if (key === 'owners'){
          let newVal="";
          for (const owner of JSON.parse(val)){
            newVal = newVal + owner.name + '(' + owner.workNo +')'+",";
          }
          val = newVal;
        }
      }
      val = val.replace(/(\r\n|\n|\r)/gm, " ");
      // 处理包含逗号、双引号或换行符的值
      if (val.search(/("|,|\n| )/g) >= 0) {
        val = `"${val.replace(/"/g, '""')}"`;
      }
      return val;
    });
    csvRows.push(values.join(','));

  }
  // BOM（Byte Order Mark）是一个用于标识文本文件编码的特殊字符序列。
  // 在CSV内容前添加UTF - 8 BOM（"\uFEFF"），可以帮助Excel正确识别文件为UTF - 8编码，防止中文乱码。
  const BOM = "\uFEFF";
  const blob = new Blob([BOM + csvRows.join('\n')], { type: 'text/csv;charset=utf-8;' });
  const url = URL.createObjectURL(blob);
  // 创建下载链接并触发下载
  const a = document.createElement('a');
  a.href = url;
  a.download = '异常明细' + convertFormatDate(Date.now()) +'.csv';
  document.body.appendChild(a);
  a.click();
  document.body.removeChild(a);
  URL.revokeObjectURL(url);
  navigator.clipboard.writeText(csvRows.join('\n'));
}
```

2. 时间格式

```
 function convertFormatDate(mills){
  const date = new Date(mills);
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, '0');
  const day = String(date.getDate()).padStart(2, '0');
  const hours = String(date.getHours()).padStart(2, '0');
  const minutes = String(date.getMinutes()).padStart(2, '0');
  const seconds = String(date.getSeconds()).padStart(2, '0');
  return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
}
```
