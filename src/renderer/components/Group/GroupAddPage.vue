<template>
    <div class="content-page">
        <div class="content-nav">
            <el-breadcrumb class="breadcrumb" separator="/">
                <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
                <el-breadcrumb-item>团购管理</el-breadcrumb-item>
                <el-breadcrumb-item>{{infoForm.tableData[0].goods_id ? '编辑团购' : '添加团购'}}</el-breadcrumb-item>
            </el-breadcrumb>
            <div class="operation-nav">
                <el-button type="primary" @click="goBackPage" icon="arrow-left">返回列表</el-button>
            </div>
        </div>
        <div class="content-main">
            <div class="form-table-box">
                <el-form ref="infoForm" :rules="rules" :model="infoForm">
                    <el-form-item>
                        <el-col :span="12" >拼团基本信息</el-col>
                        <el-col :span="12" align="right">
                            <el-button type="primary" @click="onSubmitInfo('infoForm', -1)">保存</el-button>
                            <el-button @click="onAddRow">增加行</el-button>
                        </el-col>
                    </el-form-item>
                    <el-form-item>
                        <el-col :span="4" align="right">拼团开始时间：
                        </el-col>
                        <el-col :span="6">
                            <el-form-item prop="begin_time" style="width: 100%">
                                <el-date-picker v-model="infoForm.begin_time" style="width: 100%"  type="datetime">
                                </el-date-picker>
                            </el-form-item>
                        </el-col>
                        <el-col :span="4" align="right" :offset="2">拼团结束时间：
                        </el-col>
                        <el-col :span="6">
                            <el-form-item prop="end_time">
                                <el-date-picker v-model="infoForm.end_time" style="width: 100%"  type="datetime">
                                </el-date-picker>
                            </el-form-item>
                        </el-col>
                    </el-form-item>
                    <el-form-item>
                        <el-col :span="4" align="right">成团有效时间：
                        </el-col>
                        <el-col :span="6">
                            <el-form-item prop="effect_time">
                                <el-input v-model="infoForm.effect_time"/>
                            </el-form-item>
                        </el-col>
                        <el-col :span="2">小时
                        </el-col>
                        <el-col :span="4" align="right">成团人数：
                        </el-col>
                        <el-col :span="6">
                            <el-form-item prop="success_num">
                                <el-input v-model="infoForm.success_num" placeholder="至少两人"/>
                            </el-form-item>
                        </el-col>
                        <el-col :span="2">人
                        </el-col>
                    </el-form-item>
                    <el-form-item>
                        <el-table :data="infoForm.tableData" style="width: 100%" border stripe>
                            <el-table-column align="center" label="商品ID" width="120">
                                <template scope="scope">
                                    <el-form-item :prop="'tableData.' + scope.$index + '.goods_id'" :rules="rules.goods_id">
                                        <el-input v-model="scope.row.goods_id" :disabled="true"/>
                                    </el-form-item>
                                </template>
                            </el-table-column>
                            <el-table-column align="center" label="商品名称" style="width: 100%">
                                <template slot-scope="scope">
                                    <el-form-item :prop="'tableData.' + scope.$index + '.name'" :rules="rules.name">
                                        <el-autocomplete v-model="scope.row.name" :fetch-suggestions="searchAsync"
                                                         :trigger-on-focus="false" @select="item => {handleSelect(item, scope.$index)}">
                                        </el-autocomplete>
                                    </el-form-item>
                                </template>
                            </el-table-column>
                            <el-table-column align="center" label="原价" width="100">
                                <template slot-scope="scope">
                                    <el-form-item :prop="'tableData.' + scope.$index + '.market_price'" :rules="rules.market_price">
                                        <el-input v-model="scope.row.market_price" :disabled="true"/>
                                    </el-form-item>
                                </template>
                            </el-table-column>
                            <el-table-column align="center" label="促销价" width="100">
                                <template slot-scope="scope">
                                    <el-form-item :prop="'tableData.' + scope.$index + '.retail_price'" :rules="rules.retail_price">
                                        <el-input v-model="scope.row.retail_price" :disabled="true"/>
                                    </el-form-item>
                                </template>
                            </el-table-column>
                            <el-table-column align="center" label="团购价" width="100">
                                <template slot-scope="scope">
                                    <el-form-item :prop="'tableData.' + scope.$index + '.group_price'" :rules="rules.group_price">
                                        <el-input v-model="scope.row.group_price"/>
                                    </el-form-item>
                                </template>
                            </el-table-column>
                            <el-table-column align="center" label="限购数" width="100">
                                <template slot-scope="scope">
                                    <el-form-item :prop="'tableData.' + scope.$index + '.limit_num'" :rules="rules.limit_num">
                                        <el-input v-model="scope.row.limit_num"/>
                                    </el-form-item>
                                </template>
                            </el-table-column>
                            <el-table-column align="center" fixed="right" label="操作" width="180">
                                <template slot-scope="scope">
                                    <el-button type="primary" @click="onSubmitInfo('infoForm', scope.$index)">保存</el-button>
                                    <el-button type="warning" @click="onDeleteRow(scope.$index)">删除</el-button>
                                </template>
                            </el-table-column>
                        </el-table>
                    </el-form-item>
                </el-form>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                rules: {
                    name: { required: true,message: '请输入商品名', trigger: 'blur' },
                    begin_time: { required: true, message: '开团时间不能为空', trigger: 'blur' },
                    end_time: { required: true, message: '结束时间不能为空', trigger: 'blur' },
                    effect_time: { required: true, message: '成团时间不能为空', trigger: 'blur' },
                    success_num: { required: true, message: '成团人数不能为空', trigger: 'blur' },
                    limit_num: { required: true, message: '限购数量不能为空', trigger: 'blur' },
                    group_price: { required: true, message: '团购价格不能为空', trigger: 'blur' },
                },
                infoForm: {
                    user_id: '',
                    begin_time: '',
                    end_time: '',
                    effect_time: '',
                    success_num: '',
                    tableData: [{
                        user_id: '',
                        begin_time: '',
                        end_time: '',
                        effect_time: '',
                        success_num: '',

                        goods_id: '',
                        name: '',
                        market_price: '',
                        retail_price: '',
                        group_price: '',
                        limit_num: '',
                    }],
                }
            }
        },
        methods: {
            goBackPage() {
                this.$router.go(-1);
            },
            onSubmitInfo(infoForm, index) {
                this.$refs[infoForm].validate((valid) => {
                    if (valid) {
                        console.log(this.infoForm);
                        if (index = -1) {
                            for(let i = 0; i < this.infoForm.tableData.length; i++){
                                this.infoForm.tableData[i].user_id = this.infoForm.user_id;
                                this.infoForm.tableData[i].begin_time = this.infoForm.begin_time;
                                this.infoForm.tableData[i].end_time = this.infoForm.end_time;
                                this.infoForm.tableData[i].effect_time = this.infoForm.effect_time;
                                this.infoForm.tableData[i].success_num = this.infoForm.success_num;
                                this.addGroup(this.infoForm.tableData[i]);
                            }
                        } else {
                            this.infoForm.tableData[index].user_id = this.infoForm.user_id;
                            this.infoForm.tableData[index].begin_time = this.infoForm.begin_time;
                            this.infoForm.tableData[index].end_time = this.infoForm.end_time;
                            this.infoForm.tableData[index].effect_time = this.infoForm.effect_time;
                            this.infoForm.tableData[index].success_num = this.infoForm.success_num;
                            this.addGroup(this.infoForm.tableData[index]);
                        }
                    } else {
                        return false;
                    }
                });
            },
            addGroup(data){
                this.axios.post('group/add', data).then((response) => {
                    if (response.data.errno === 0) {
                        this.$message({
                            type: 'success',
                            message: '保存成功'
                        });
                        this.$router.go(-1)
                    } else {
                        this.$message({
                            type: 'error',
                            message: '保存失败'
                        })
                    }
                })
            },
            onAddRow() {
                this.infoForm.tableData.push({goods_id: ''});
            },
            onDeleteRow(index) {
                this.infoForm.tableData.splice(index, 1)
            },
            handleSelect(item, index) {
                this.infoForm.tableData[index].goods_id = item.id;
                this.infoForm.tableData[index].name = item.name;
                this.infoForm.tableData[index].market_price = item.market_price;
                this.infoForm.tableData[index].retail_price = item.retail_price;
            },
            searchAsync(queryStr, cb) {
                this.axios.get('goods', {
                    params: {
                        page: 1,
                        name: queryStr
                    }
                }).then((response) => {
                    //this.tableData = response.data.data.data
                    const data = response.data.data.data.map(obj => {
                        obj.value = obj.name;
                        return obj;
                    })
                    console.log(data)
                    cb(data)
                })
            }
        },
        components: {

        },
        mounted() {
            this.infoForm.tableData[0].goods_id = this.$route.query.id || '';
        }
    }
</script>

<style scoped>

</style>