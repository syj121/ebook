<style lang="less">
  @import './login.less';
</style>

<template>
  <div class="login">
    <div class="login-con">
      <Card icon="log-in" title="欢迎登录" :bordered="false">
        <div class="form-con">
          <login-form @on-success-valid="handleSubmit" ref="myloginform"></login-form>
          <p class="login-tip" :style="{color: tipColor, 'font-size': tipSize}">{{tipMsg}}</p>
        </div>
      </Card>
    </div>
  </div>
</template>

<script>
import LoginForm from '_c/login-form'
import { mapActions } from 'vuex'
export default {
  data () {
    return {
      tipMsg: '输入任意用户名和密码即可',
      tipColor: '',
      tipSize: ''
    }
  },
  components: {
    LoginForm
  },
  methods: {
    ...mapActions([
      'handleLogin',
      'getUserInfo'
    ]),
    handleSubmit ({ userName, password }) {
      // 登录直接获取信息，不用再次获取
      this.handleLogin({ userName, password }).then(res => {
        if (res.success) {
          this.getUserInfo().then(res => {
            this.$router.push({
              name: this.$config.homeName
            })
          })
        } else {
          this.tipMsg = res.msg
          this.tipColor = 'red'
          this.tipSize = '14px'
        }
      })
    }
  }
}
</script>

<style>

</style>
