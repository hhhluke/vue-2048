<template>
    <div class="wrapper">
        <div class="box">
            <div class="row" v-for="row in list">
                <div class="col" :class="'n-'+col" v-for="col in row">{{col}}</div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                size: 4,
                score: 0,
                list: [],
                intiNum: [2, 4],
                pr: 0.9,
            }
        },
        mounted() {
            //初始化数组
            this.init()
        },
        methods: {
            init() {
                this.list = Array.from(Array(this.size)).map(() => Array(this.size).fill(undefined))
                this.setRandom()
                // this.setRandom()
                document.addEventListener('keyup', this.keyDown)
            },
            //插入新格子
            setRandom() {
                if (this.hasAvailableCells()) {
                    let [x, y] = this.randomAvailableCells()
                    this.list[x][y] = this.randomValue()
                }
            },
            //获取数值
            randomValue() {
                return Math.random() < this.pr ? this.intiNum[0] : this.intiNum[1]
            },
            //获取随机一个空格子坐标
            randomAvailableCells() {
                let cells = this.availableCells()
                // console.log('cells', cells);
                if (cells.length) {
                    return cells[Math.floor(Math.random() * cells.length)]
                }
            },
            //所有空格子的坐标
            availableCells() {
                let cells = []
                for (let i = 0; i < this.size; i++) {
                    for (let j = 0; j < this.size; j++) {
                        if (!this.list[i][j]) {
                            cells.push([i, j])
                        }
                    }
                }
                return cells
            },
            //是否存在空格子
            hasAvailableCells() {
                return !!this.availableCells().length
            },
            //获取0-n的随机数
            randomNum(index) {
                return Math.floor(Math.random() * index)
            },
            //键盘监听事件
            keyDown(e) {
                if ([38, 40, 37, 39].includes(e.keyCode)) {
                    this.list.forEach((item,index) => {
                        // item = this.moveLeft(item)
                        // console.log(123,this.moveLeft(item));
                        this.$set(this.list,index,this.moveLeft(item))
                    })
                console.log(this.list);
                }
                // this.$set(this.list)
            },
            moveLeft(list) {
                // console.log('init',list);
                let _list = [] //当前行非空格子
                for (let i = 0; i < this.size; i++) {
                    if (list[i]) {
                        _list.push({
                            x: i,
                            merged: false,
                            value: list[i]
                        })
                    }
                }
                // console.log('_list',_list);
                _list.forEach(item => {
                    console.log(item);
                    let [_prev, _cell] = this.farthestPosition(list,item)
                    if(list[_cell.x] && list[_cell.x] === item && !list[_cell.x].merged) {
                        //合并
                    }else {
                        if(_prev) {
                            list[_prev.x] = item.value
                            list[item.x] = undefined
                        }
                    }
                })
                // console.log('list',list);
                return list
            },
            farthestPosition(list, cell) {
                cell = JSON.parse(JSON.stringify(cell))
                var previous
                while (cell.x - 1 >= 0 && !list[cell.x - 1]){
                    previous = cell
                    cell.x = previous.x - 1
                }
                // console.log(123,previous,cell);
                return [previous,cell]
            }
        }
    }

</script>

<style scoped lang="less">
    .wrapper {
        display: flex;
        justify-content: center;
        .box {
            width: 400px;
            height: 400px;
            padding: 15px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            border-radius: 5px;
            background: #bbada0;
            .row {
                width: 100%;
                height: 23%;
                display: flex;
                flex-direction: row;
                justify-content: space-between;
                .col {
                    width: 23%;
                    height: 100%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 24px;
                    border-radius: 3px;
                    background: #cec1b3;
                    &.n-2 {
                        background: #f8f3e8;
                    }
                    &.n-4 {
                        background: #ede0c8;
                    }
                }
            }
        }
    }

</style>
