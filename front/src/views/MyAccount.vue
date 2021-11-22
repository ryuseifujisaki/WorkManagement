<template>
  <div>
    <!-- すでに参加していたらsnackbarを表示 -->
    <UserHeader></UserHeader>
    <v-container class="text-center justify-center py-6">
      <h1>My Account</h1>
      <p align="right">ようこそ{{ this.name }}</p>
      <!-- User情報 -->
      <v-row>
        <v-col cols="2"></v-col>
        <v-col cols="8">
          <v-card elevation="7">
            name
            <br />
            <h4>{{ this.name }}</h4>
          </v-card>
          <br />
          <v-card elevation="7">
            email
            <br />
            <h4>{{ this.email }}</h4>
          </v-card>
          <br />
          <v-card elevation="7">
            tel
            <br />
            <h4>{{ this.tel }}</h4>
          </v-card>
          <br />
          <v-card elevation="7">
            grade
            <br />
            <h4>{{ this.grade }}</h4>
          </v-card>
          <br />
          <v-card elevation="7">
            course
            <br />
            <h4>{{ this.course }}</h4>
          </v-card>
          <br />
          <v-btn @click="open">編集はこちら</v-btn>
          <!-- 編集ダイアログ -->
          <v-dialog v-model="dialog">
            <v-card>
              <v-row>
                <v-col cols="1"></v-col>
                <v-col cols="10">
                  <v-container class="text-center justify-center py-6">
                    <h4>Account edit</h4>
                    <v-form ref="form" v-model="valid" lazy-validation>
                      <v-text-field
                        label="name"
                        v-model="name"
                        :rules="rules"
                        required
                      >
                      </v-text-field>
                      <v-text-field
                        label="email"
                        v-model="email"
                        :rules="emailRules"
                        required
                      >
                      </v-text-field>
                      <v-text-field
                        label="tel"
                        v-model="tel"
                        :rules="rules"
                        required
                      >
                      </v-text-field>
                      <v-select
                        v-model="grade"
                        :hint="`${select.grade}`"
                        :items="grades"
                        item-text="grade"
                        label="grade"
                        persistent-hint
                        return-object
                        single-line
                        :rules="rules"
                        required
                      >
                      </v-select>
                      <v-select
                        v-model="course"
                        :hint="`${select.course}`"
                        :items="courses"
                        item-text="course"
                        label="course"
                        persistent-hint
                        return-object
                        single-line
                        :rules="rules"
                        required
                      ></v-select>
                      <br />
                      <div class="btnspace">
                        <v-btn @click="close">戻る</v-btn>
                        <v-btn
                          @click="
                            validate;
                            edit();
                          "
                          >編集の確定</v-btn
                        >
                      </div>
                    </v-form>
                  </v-container>
                </v-col>
                <v-col cols="1"></v-col>
              </v-row>
            </v-card>
          </v-dialog>
        </v-col>
        <v-col cols="2"></v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import axios from "axios";
import UserHeader from "@/components/UserHeader.vue";
export default {
  data() {
    return {
      name: "",
      email: "",
      grade: "",
      tel: "",
      course: "",
      dialog: false,
      valid: true,
      select: { course: "例)機械創造工学課程", grade: "例)B4" },
      //入力規則
      rules: [(v) => !!v || "必須項目"],
      //email規則
      emailRules: [
        (v) => !!v || "必須項目",
        (v) => /.+@.+\..+/.test(v) || "不適切なメールアドレスです",
      ],
      //tel規則
      //telRules: [(v) => !!v || "必須項目"],

      courses: [
        { course: "機械創造工学課程" },
        { course: "電気電子情報工学課程" },
        { course: "物質材料工学課程" },
        { course: "環境社会基盤工学課程" },
        { course: "生物機能工学課程" },
        { course: "情報・経営システム工学課程" },
        { course: "機械創造工学専攻" },
        { course: "電気電子情報工学専攻" },
        { course: "物質材料工学専攻" },
        { course: "環境社会基盤工学専攻" },
        { course: "生物機能工学専攻" },
        { course: "情報・経営システム工学専攻" },
        { course: "原子力,システム安全,技ノベ,その他" },
      ],
      grades: [
        { grade: "B1" },
        { grade: "B2" },
        { grade: "B3" },
        { grade: "B4" },
        { grade: "M1" },
        { grade: "M2" },
        { grade: "D1" },
        { grade: "D2" },
        { grade: "D3" },
      ],
    };
  },
  components: {
    UserHeader,
  },
  //ダイアログオープン
  methods: {
    open: function () {
      this.dialog = true;
    },
    //ダイアログクローズ
    close: function () {
      this.dialog = false;
    },
    //入力規則
    validate() {
      this.$refs.form.validate();
      console.log(this.valid);
    },
    //編集の確定
    edit: function () {
      console.log(this.valid);
      if (this.valid == true) {
        const url = process.env.VUE_APP_URL;
        var params = {
          name: this.name,
          email: this.email,
          course: this.course.course,
          tel: this.tel,
          grade: this.grade.grade,
        };
        axios
          .put(url + "/api/auth", params, {
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
      }
    },
  },
  //User情報取得
  mounted: async function () {
    const url = process.env.VUE_APP_URL;
    axios
      .get(url + "/api/v1/current_user/show", {
        headers: {
          "Content-Type": "application/json",
          "access-token": localStorage.getItem("access-token"),
          client: localStorage.getItem("client"),
          uid: localStorage.getItem("uid"),
        },
      })
      .then((response) => {
        console.log(response.data.data);
        this.name = response.data.data.name;
        this.email = response.data.data.email;
        this.tel = response.data.data.tel;
        this.grade = response.data.data.grade;
        this.course = response.data.data.course;
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
