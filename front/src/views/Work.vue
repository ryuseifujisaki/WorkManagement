<template>
  <!-- すでに参加していたらsnackbarを表示 -->
  <div>
    <UserHeader></UserHeader>
    <div v-if="snackbar === true">
      <v-snackbar type="error" v-model="snackbar">
        {{ text }}
        <v-btn @click="close">閉じる</v-btn>
      </v-snackbar>
    </div>
    <v-container class="text-center justify-center py-6">
      <h1 class="justify-center">Work Information</h1>
    </v-container>
    <h3 class="text-right justify px-9">ようこそ {{ this.usersName }}</h3>
    <v-row>
      <v-col cols="2"></v-col>
      <v-col cols="8">
        <v-form
          v-for="work in works"
          :key="work.id"
          class="text-center justify-center py-6"
        >
          <v-card>
            <br />
            案件:{{ work.name }}
            <br />
            日時: {{ work.day }}
            <br />
            会場:{{ work.where }}
            <br />
            支払い額:{{ work.money }}
            <br />
            交通費:{{ work.carfare }}
            <br />
            募集人員:{{ work.limit }}人
            <br />
            作業内容:{{ work.content }}
            <br />
            服装:{{ work.cloth }}
            <br />
            メンバー:
            <ul v-for="n of work.usernames" :key="n">
              {{
                n
              }}
            </ul>
            <v-spacer class="py-5"></v-spacer>
            <div class="btnspace">
              <v-btn elevation="10" @click="cancell(work.id)">キャンセル</v-btn>
              <v-btn elevation="10" @click="register(work.id)">参加する</v-btn>
            </div>
            <br />
            <br />
          </v-card>
        </v-form>
      </v-col>
      <v-col cols="2"></v-col>
    </v-row>
  </div>
</template>

<script>
import axios from "axios";
import UserHeader from "@/components/UserHeader.vue";
export default {
  data() {
    return {
      dialog: null,
      works: [],
      workId: "",
      workUsers: [],
      workNum: "",
      usersName: null,
      userId: "",
      flag: null,
      check: "check",
      snackbar: false,
      text: "すでに参加しているかこの案件の人数が満たしています",
    };
  },
  components: {
    UserHeader,
  },

  methods: {
    register: async function (workId) {
      var params = {
        user_id: this.userId,
        work_id: workId,
      };
      const url = process.env.VUE_APP_URL + "/user_works";
      await axios
        .post(url, params, {
          headers: {
            "Content-Type": "application/json",
            "access-token": localStorage.getItem("access-token"),
            client: localStorage.getItem("client"),
            uid: localStorage.getItem("uid"),
          },
        })
        .then((response) => {
          this.check = response.data.id;
          console.log(this.check);
          if (this.check == undefined) {
            this.snackbar = true;
          } else {
            location.reload();
          }
        });
    },
    cancell: async function (workId) {
      var params = {
        user_id: this.userId,
        work_id: workId,
      };
      const url = process.env.VUE_APP_URL + "/user_work/cancell/";
      await axios
        .put(url, params, {
          headers: {
            "Content-Type": "application/json",
            "access-token": localStorage.getItem("access-token"),
            client: localStorage.getItem("client"),
            uid: localStorage.getItem("uid"),
          },
        })
        .then((response) => {
          console.log(response);
          location.reload();
        });
    },
    //処理を待つ関数
    blockTime: async function (timeout) {
      const startTime = Date.now();
      // `timeout`ミリ秒経過するまで無限ループをする
      for (;;) {
        const diffTime = Date.now() - startTime;
        if (diffTime >= timeout) {
          return; // 指定時間経過したら関数の実行を終了
        }
      }
    },
  },

  mounted: async function () {
    const url = process.env.VUE_APP_URL;
    //直アクセスの拒否
    await axios
      .get(url + "/api/v1/current_user/get_user_signin", {
        headers: {
          "Content-Type": "application/json",
          "access-token": localStorage.getItem("access-token"),
          client: localStorage.getItem("client"),
          uid: localStorage.getItem("uid"),
        },
      })
      .then((response) => {
        this.flag = response.data.flag;
        if (this.flag == false) {
          this.$router.push("/");
        }
      });
    await axios
      .get(url + "/api/v1/work_user/get_work_detail", {
        headers: {
          "Content-Type": "application/json",
          "access-token": localStorage.getItem("access-token"),
          client: localStorage.getItem("client"),
          uid: localStorage.getItem("uid"),
        },
      })
      .then((response) => {
        console.log(response.data);
        this.works = response.data;
      });
    await axios
      .get(url + "/api/v1/current_user/show", {
        headers: {
          "Content-Type": "application/json",
          "access-token": localStorage.getItem("access-token"),
          client: localStorage.getItem("client"),
          uid: localStorage.getItem("uid"),
        },
      })
      .then((response) => {
        console.log(response);
        console.log(response.headers);
        this.usersName = response.data.data.name;
        this.userId = response.data.data.id;
      });
  },
};
</script>
<style>
.btnspace {
  display: flex;
  justify-content: space-around;
}
</style>
