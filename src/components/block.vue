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
                size:4,
                score: 0,
                list: [],
                intiNum: [2,4],
                pr: 0.9,
            }
        },
        mounted() {
            //初始化数组
            this.init()
        },
        methods: {
            init() {
                this.list = Array.from(Array(4)).map(() => Array(4).fill(undefined))
                this.setRandom()
                // this.setRandom()
                document.addEventListener('keyup', this.keyDown)
            },
            setRandom() {
                if(this.hasAvailableCells()) {
                    let [x,y] = this.randomAvailableCells()
                    console.log(x,y);
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
                console.log('cells',cells);
                if(cells.length) {
                    return cells[Math.floor(Math.random() * cells.length)]
                }
            },
            //所有空格子的坐标
            availableCells() {
                let cells = []
                    for(let i = 0;i < this.size; i++) {
                        for(let j = 0; j< this.size; j++) {
                            if(!this.list[i][j]) {
                                cells.push([i,j])
                            }
                        }
                    }
                return cells
            },
            hasAvailableCells() {
                return !!this.availableCells().length
            },
            //获取0-n的随机数
            randomNum(index) {
                return Math.floor(Math.random() * index)
            },
            keyDown(e) {
                if ([38, 40, 37, 39].includes(e.keyCode)) {
                    console.log(e.keyCode);
                }
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
