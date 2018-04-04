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
                switch (e.keyCode) {
                    case 38://上3
                    console.log(this.T(Array.from(this.list),3));
                        // let arr = this.T(Array.from(this.list),3).map((item, index) => {
                        //     return this.moveLeft(item)
                        // })
                        // this.list = this.T(arr,1)
                        break
                    case 40://下1
                        this.list.forEach((item, index) => {
                            this.$set(this.list, index, this.moveLeft(item))
                        })
                        break
                    case 37://左0
                        this.list.forEach((item, index) => {
                            this.$set(this.list, index, this.moveLeft(item))
                        })
                        break
                    case 38://右2
                        this.list.forEach((item, index) => {
                            this.$set(this.list, index, this.moveLeft(item))
                        })
                        break
                }
                // this.setRandom()
            },
            //单行左移
            moveLeft(list) {
                let _list = [] //当前行非空格子
                let flg = false
                for (let i = 0; i < this.size; i++) {
                    if (list[i]) {
                        _list.push({
                            x: i,
                            merged: false,
                            value: list[i]
                        })
                    }
                }
                _list.forEach(item => {
                    let farthest = this.farthestPosition(list, item)
                    let next = list[farthest - 1]
                    if (next && next === item.value && !_list[farthest - 1].merged) {
                        //合并
                        list[farthest - 1] = next * 2
                        list[item.x] = undefined
                        item = {
                            x: farthest - 1,
                            merged: true,
                            value: next * 2
                        }
                    } else {
                        if (farthest != item.x) {
                            list[farthest] = item.value
                            list[item.x] = undefined
                            item.x = farthest
                        }
                    }
                })
                return list
            },
            T(arr, n) {
                n = n % 4;
                if (n === 0) return arr;
                var l = arr.length,
                    d = Math.sqrt(l),
                    tmp = [];
                for (var i = 0; i < d; i += 1)
                    for (var j = 0; j < d; j += 1)
                        tmp[d - i - 1 + j * d] = arr[i * d + j];
                if (n > 1) tmp = this.T(tmp, n - 1);
                return tmp;
            },
            farthestPosition(list, cell) {
                let farthest = cell.x
                while (farthest > 0 && !list[farthest - 1]) {
                    farthest = farthest - 1
                }
                return farthest
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
