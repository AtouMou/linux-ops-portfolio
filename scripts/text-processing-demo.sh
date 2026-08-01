#!/bin/bash
# 文本处理三剑客演示

echo "=== 创建测试数据 ==="
mkdir -p /tmp/text_test
cat > /tmp/text_test/users.csv << 'CSV'
id,name,age,city,score
1,Alice,25,Beijing,85
2,Bob,30,Shanghai,92
3,Charlie,28,Guangzhou,78
4,David,22,Shenzhen,95
5,Eve,27,Beijing,88
CSV
cat /tmp/text_test/users.csv

echo ""
echo "=== grep 演示 ==="
echo "查找 Beijing 的记录:"
grep "Beijing" /tmp/text_test/users.csv

echo ""
echo "查找年龄大于25的记录:"
grep -E "[0-9]+,[A-Za-z]+,2[6-9]," /tmp/text_test/users.csv

echo ""
echo "=== awk 演示 ==="
echo "打印姓名和分数:"
awk -F',' '{print $2, $5}' /tmp/text_test/users.csv

echo ""
echo "计算平均分:"
awk -F',' '$1>1 {sum+=$5; count++} END {print "平均分:", sum/count}' /tmp/text_test/users.csv

echo ""
echo "=== sed 演示 ==="
echo "原始内容:"
head -3 /tmp/text_test/users.csv

echo ""
echo "替换后的内容（Beijing -> Tianjin）:"
sed 's/Beijing/Tianjin/g' /tmp/text_test/users.csv | head -3

echo ""
echo "=== 综合练习 ==="
echo "找出分数最高的人:"
awk -F',' 'NR>1 && $5>max {max=$5; name=$2} END {print "最高分:", max, "姓名:", name}' /tmp/text_test/users.csv

echo ""
echo "统计各城市人数:"
awk -F',' 'NR>1 {count[$4]++} END {for (city in count) print city, count[city]}' /tmp/text_test/users.csv

# 清理
rm -rf /tmp/text_test
