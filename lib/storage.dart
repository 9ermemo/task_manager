ListView
(
shrinkWrap: true
,
children: [
SizedBox
(
height: 100
)
,
GetBuilder<UtilController>
(
builder: (
notUsed) {
return Center(
child: Slider(
divisions: 10,
mouseCursor: MouseCursor.defer,
label: utilController.start.toString(),
value: utilController.start,
min: min,
max: max,
onChanged: utilController.selectValue,
),
);
},
)
,
]
,
);


-------------------------------------------------------------------------------------
