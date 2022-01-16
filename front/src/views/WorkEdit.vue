<template>
  <div>
    <AdminHeader></AdminHeader>
    <v-container class="text-center justify-center py-6">
      <h1 class="justify-center">Work Edit</h1>
      <p align="right">管理者専用ページ</p>
      <p align="right">{{ this.userName }}</p>
      <p align="right"><a href="/">user signin page</a></p>
      <v-data-table :headers="headers" :items="works" @click:row="open">
      </v-data-table>
      <v-dialog v-model="dialog" max-width="600px">
        <v-card-text class="text-center white">
          <v-row>
            <v-col cols="2"></v-col>
            <v-col cols="8">
              No:{{ this.id }}
              <br />
              案件:{{ this.name }}
              <br />
              人数:{{ this.limit }}
              <br />
              日付:{{ this.day }}
              <br />
              場所:{{ this.where }}
              <br />
              交通費:{{ this.carfare }}
              <br />
              内容:{{ this.content }}
              <br />
              服装:{{ this.cloth }}
              <br />
              持ち物:{{ this.belonging }}
              <br />
              その他:{{ this.other }}
              <br />
              <div class="btnspace">
                <v-btn @click="openedit">この案件を編集する</v-btn>
                <v-btn color="error" @click="openconfirm">この案件を消去</v-btn>
              </div>
              <!-- 編集ダイアログ -->
              <v-dialog v-model="editDialog">
                <v-card>
                  <v-row>
                    <v-col cols="2"></v-col>
                    <v-col cols="8">
                      <div class="text-center">
                        <br />
                        <h1>Edit</h1>
                        <v-form ref="form" lazy-validation>
                          <v-text-field
                            label="Work_name"
                            v-model="name"
                            :rules="rules"
                          >
                          </v-text-field>
                          <v-text-field
                            label="Number of people"
                            v-model="limit"
                            :rules="rules"
                          >
                          </v-text-field>
                          <v-text-field
                            label="Day"
                            v-model="day"
                            :rules="rules"
                          >
                          </v-text-field>
                          <v-text-field
                            label="money"
                            v-model="money"
                            :rules="rules"
                          >
                          </v-text-field>
                          <v-text-field
                            label="Where"
                            v-model="where"
                            :rules="rules"
                          >
                          </v-text-field>
                          <v-text-field label="Carfare" v-model="carfare">
                          </v-text-field>
                          <v-text-field
                            label="content"
                            v-model="content"
                            :rules="rules"
                          >
                          </v-text-field>
                          <v-text-field
                            label="cloth"
                            v-model="cloth"
                            :rules="rules"
                          >
                          </v-text-field>
                          <v-text-field label="belonging" v-model="belonging">
                          </v-text-field>
                          <v-text-field label="other" v-model="other">
                          </v-text-field>
                          <v-btn
                            @click="
                              validate();
                              workedit();
                            "
                            >編集を完了します</v-btn
                          >
                        </v-form>
                      </div>
                    </v-col>
                    <v-col cols="2"></v-col>
                  </v-row>
                </v-card>
              </v-dialog>
              <!-- 消去ダイアログ -->
              <v-dialog v-model="confirmdialog">
                <v-card color="white">
                  <div class="text-center">
                    <h2>本当によろしいですか？</h2>
                    <div class="btnspace">
                      <v-btn color="error" @click="workdelete">消去</v-btn>
                    </div>
                  </div>
                </v-card></v-dialog
              >
            </v-col>
            <v-col cols="2"></v-col>
          </v-row>
        </v-card-text>
      </v-dialog>
    </v-container>
  </div>
</template>
<script>
import axios from "axios";
import AdminHeader from "@/components/AdminHeader.vue";
export default {
  data() {
    return {
      dialog: false,
      editDialog: false,
      confirmdialog: false,
      search: "",
      userName: null,
      id: null,
      name: "",
      limit: "",
      day: "",
      money: "",
      where: "",
      carfare: "",
      content: "",
      cloth: "",
      belonging: "",
      other: "",
      flag: null,
      works: [],
      work: [],
      headers: [
        {
          text: "No",
          align: "start",
          sortable: "false",
          value: "id",
          width: `2%`,
        },
        {
          text: "Workname",
          align: "start",
          sortable: "false",
          value: "name",
          width: `11%`,
        },
        {
          text: "People limit",
          align: "start",
          sortable: "false",
          value: "limit",
          width: `3%`,
        },
        {
          text: "Day",
          align: "start",
          sortable: "false",
          value: "day",
          width: `15%`,
        },
        {
          text: ":where",
          align: "start",
          sortable: "false",
          value: "where",
          width: `13%`,
        },
        {
          text: ":money",
          align: "start",
          sortable: "false",
          value: "money",
          width: `10%`,
        },
        {
          text: ":carfare",
          align: "start",
          sortable: "false",
          value: "carfare",
          width: `10%`,
        },
        {
          text: ":content",
          align: "start",
          sortable: "false",
          value: "content",
          width: `11%`,
        },
        {
          text: ":cloth",
          align: "start",
          sortable: "false",
          value: "cloth",
          width: `10%`,
        },
        {
          text: ":belonging",
          align: "start",
          sortable: "false",
          value: "belonging",
          width: `10%`,
        },
        {
          text: ":other",
          align: "start",
          sortable: "false",
          value: "other",
          width: `15%`,
        },
      ],
      //rule規則
      rules: [(v) => !!v || "必須項目"],
    };
  },
  components: {
    AdminHeader,
  },
  methods: {
    //テーブル列クリック関数
    open(row) {
      this.dialog = true;
      this.id = row.id;
      this.name = row.name;
      this.limit = row.limit;
      this.day = row.day;
      this.where = row.where;
      this.money = row.money;
      this.carfare = row.carfare;
      this.content = row.content;
      this.cloth = row.cloth;
      this.belonging = row.belonging;
      this.other = row.other;
    },
    openconfirm() {
      this.dialog = false;
      this.confirmdialog = true;
    },
    //案件消去
    workdelete: function () {
      const url = process.env.VUE_APP_URL;
      axios
        .delete(url + "/works/" + this.id, {
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
    //ダイアログオープン
    openedit() {
      this.dialog = false;
      this.editDialog = true;
    },
    //入力規制
    validate() {
      this.$refs.form.validate();
    },

    workedit: function () {
      const url = process.env.VUE_APP_URL;
      var params = {
        name: this.name,
        limit: this.limit,
        day: this.day,
        money: this.money,
        where: this.where,
        carfare: this.carfare,
        content: this.content,
        cloth: this.cloth,
        belonging: this.belonging,
        other: this.other,
      };
      axios
        .put(url + "/works/" + this.id, params, {
          headers: {
            "Content-Type": "application/json",
            "access-token": localStorage.getItem("access-token"),
            client: localStorage.getItem("client"),
            uid: localStorage.getItem("uid"),
          },
        })
        .then((response) => {
          console.log(response);
          this.editDialog = false;
          location.reload();
        });
    },
  },
  mounted: function () {
    //ログインしていないページ遷移の拒否
    const url = process.env.VUE_APP_URL;
    axios
      .get(url + "/api/v1/current_admin/get_admin_signin", {
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
          this.$router.push("/adminsignin");
        }
      });
    //adminuser情報取得
    axios
      .get(url + "/api/v1/current_admin/show", {
        headers: {
          "Content-Type": "application/json",
          "access-token": localStorage.getItem("access-token"),
          client: localStorage.getItem("client"),
          uid: localStorage.getItem("uid"),
        },
      })
      .then((response) => {
        this.userName = response.data.data.name;
      });
    //work情報取得
    axios
      .get(url + "/works", {
        headers: {
          "Content-Type": "application/json",
          "access-token": localStorage.getItem("access-token"),
          client: localStorage.getItem("client"),
          uid: localStorage.getItem("uid"),
        },
      })
      .then((response) => {
        console.log(response);
        this.works = response.data;
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
