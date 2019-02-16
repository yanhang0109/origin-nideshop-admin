<template>
    <div class="content-page">
        <div class="content-nav">
            <el-breadcrumb class="breadcrumb" separator="/">
                <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
                <el-breadcrumb-item>团购管理</el-breadcrumb-item>
                <el-breadcrumb-item>团购商品列表</el-breadcrumb-item>
            </el-breadcrumb>
            <div class="operation-nav">
                <router-link to="/dashboard/group/add">
                    <el-button type="primary" icon="plus">添加团购</el-button>
                </router-link>
            </div>
        </div>
        <div class="content-main">
            <div class="filter-box">
                <el-form :inline="true" :model="filterForm" class="demo-form-inline">
                    <el-form-item label="商品名称">
                        <el-input v-model="filterForm.name" placeholder="商品名称"></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-button type="primary" @click="onSubmitFilter">查询</el-button>
                    </el-form-item>
                </el-form>
            </div>
            <div class="form-table-box">
                <el-table :data="tableData" style="width: 100%" border stripe>
                    <el-table-column align="center"  prop="id" label="商品ID" width="100">
                    </el-table-column>
                    <el-table-column align="center"  prop="name" label="商品名称">
                    </el-table-column>
                    <el-table-column align="center"  prop="retail_price" label="原价" width="80">
                    </el-table-column>
                    <el-table-column align="center"  prop="sales_price" label="促销价" width="80">
                    </el-table-column>
                    <el-table-column align="center"  prop="group_price" label="团购价" width="80">
                    </el-table-column>
                    <el-table-column align="center"  prop="begin_time" label="开始时间" width="120">
                    </el-table-column>
                    <el-table-column align="center"  prop="end_time" label="结束时间" width="120">
                    </el-table-column>
                    <el-table-column align="center"  prop="effect_time" label="成团时间" width="60">
                    </el-table-column>
                    <el-table-column align="center"  prop="success_num" label="成团人数" width="60">
                    </el-table-column>
                    <el-table-column align="center"  prop="status" label="活动状态" width="60">
                    </el-table-column>
                    <el-table-column align="center"  fixed="right" label="操作" width="160">
                        <template scope="scope">
                            <el-button size="small" type="primary" @click="handleRowEdit(scope.$index, scope.row)">编辑</el-button>
                            <el-button size="small" type="danger" @click="handleRowDelete(scope.$index, scope.row)">删除</el-button>
                        </template>
                    </el-table-column>
                </el-table>
            </div>
            <div class="page-box">
                <el-pagination @current-change="handlePageChange" :current-page="page" :page-size="10" layout="total, prev, pager, next, jumper" :total="total">
                </el-pagination>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
      data () {
        return {
          page: 1,
          total: 0,
          filterForm: {
            name: ''
          },
          tableData: []
        }
      },
      methods: {
        handlePageChange (val) {
          this.page = val
          // 保存到localStorage
          localStorage.setItem('goodsPage', this.page)
          localStorage.setItem('goodsFilterForm', JSON.stringify(this.filterForm))
          this.getList()
        },
        handleRowEdit (index, row) {
          this.$router.push({ name: 'group_add', query: { id: row.id } })
        },
        handleRowDelete (index, row) {
          this.$confirm('确定要删除?', '提示', {
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            this.axios.post('group/destory', { id: row.id }).then((response) => {
              console.log(response.data)
              if (response.data.errno === 0) {
                this.$message({
                  type: 'success',
                  message: '删除成功!'
                })

                this.getList()
              }
            })
          })
        },
        onSubmitFilter () {
          this.page = 1
          this.getList()
        },
        getList () {
          this.axios.get('goods', {
            params: {
              page: this.page,
              name: this.filterForm.name
            }
          }).then((response) => {
            this.tableData = response.data.data.data
            this.page = response.data.data.currentPage
            this.total = response.data.data.count
          })
        }
      },
      components: {

      },
      mounted () {
        this.getList()
      }
    }
</script>

<style scoped>

</style>