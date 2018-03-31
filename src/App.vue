<template>
  <div id="app">
    <Block/>
  </div>
</template>

<script>
import Block from './components/block'

export default {
  name: 'App',
  components: {
    Block
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
