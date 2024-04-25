## 模型介绍

Vicuna是由UC伯克利、CMU、斯坦福等机构的学者联手发布的开源大模型。它是一个开源聊天机器人，通过对从ShareGPT平台上的用户共享对话数据进行LLaMA的微调来进行训练。总的来说，Vicuna是一个强大且具有广泛应用前景的大语言模型，可以针对用户的问题和要求提供适当的答复和支持。

## 调用流程

1. 鉴权认证：使用appId secretKey 访问 http://{网关地址}/api/v1/ability_sub/external/getToken?appid=[appid]&secret=[secret key] 获取token。appid和secret通过订阅能力获取。
2. 模型请求：选择一种HTTP请求格式，参见下一节请求说明。将第一步获取的accessToken做为url参数传递。具体请求url见“我的能力”能力详情。

## 接口说明

### 注意事项

仅支持文本数据请求和application/json类型返回。

#### 1.1 接口名称

Chat：给定一个由对话组成的消息列表，模型将返回响应。

#### 1.2 请求说明

- HTTP方法：POST

- 请求地址：/v1/chat/completions

- Header参数：Content-Type: application/json

- Body参数

  | 参数     | 是否必选 | 类型      | 说明         |
  | -------- | -------- | --------- | ------------ |
  | model    | 是       | String    | 模型名称     |
  | messages | 是       | JsonArray | 对话消息列表 |
  | role     | 是       | String    | 角色         |
  | content  | 是       | String    | 内容         |

- 请求代码示例

```
  # 单轮对话
  curl http://{网关地址}/{能力ID}/v1/chat/completions?accessToken=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhYmlsaXR5U3RhdHVzIjoiMSIsImFiaWxpdHlOYW1lIjoiQ2hhdEdMTSIsImNsdXN0ZXJOYW1lIjoiaG9zdCIsImFwcElkIjoiNmI1MWM2ODU4NjAxNGM4YTA1MTg5NWI4ZWUyNTRmODkiLCJhYmlsaXR5QXJlYSI6IjAiLCJhYmlsaXR5U3VwcGxpZXIiOiLlubPlj7AiLCJ1c2VyTmFtZSI6InB0aGVuYW4iLCJhYmlsaXR5SWQiOiJhcHAtMDcwOTM2NDZwYnlnIiwiZnJvbUNvbXBhbnkiOiJoZW5hbiIsImV4cCI6MTcwMDAzMzQ5OCwiaWF0IjoxNzAwMDI5ODk4fQ.KHGWKbkDnLpQ7Jk431ONOE_CIsWwuAf_conNjcc3p3Q \
    -H "Content-Type: application/json" \
    -d '{
      "model": "vicuna-7b-v1.5-16k",
      "messages": [{"role": "user", "content": "Hello! What is your name?"}]
    }'
  
  # 多轮对话
  curl http://{网关地址}/{能力ID}/v1/chat/completions?accessToken=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhYmlsaXR5U3RhdHVzIjoiMSIsImFiaWxpdHlOYW1lIjoiQ2hhdEdMTSIsImNsdXN0ZXJOYW1lIjoiaG9zdCIsImFwcElkIjoiNmI1MWM2ODU4NjAxNGM4YTA1MTg5NWI4ZWUyNTRmODkiLCJhYmlsaXR5QXJlYSI6IjAiLCJhYmlsaXR5U3VwcGxpZXIiOiLlubPlj7AiLCJ1c2VyTmFtZSI6InB0aGVuYW4iLCJhYmlsaXR5SWQiOiJhcHAtMDcwOTM2NDZwYnlnIiwiZnJvbUNvbXBhbnkiOiJoZW5hbiIsImV4cCI6MTcwMDAzMzQ5OCwiaWF0IjoxNzAwMDI5ODk4fQ.KHGWKbkDnLpQ7Jk431ONOE_CIsWwuAf_conNjcc3p3Q \
    -H "Content-Type: application/json" \
    -d '{
      "model": "vicuna-7b-v1.5-16k",
      "messages": [
          {"role": "system", "content": "You are a helpful assistant."},
          {"role": "user", "content": "Who won the world series in 2020?"},
          {"role": "assistant", "content": "The Los Angeles Dodgers won the World Series in 2020."},
          {"role": "user", "content": "Where was it played?"}
      ]
  }'
```

#### 1.3 返回说明

- 返回参数

  | 参数              | 类型      | 说明               |
  | ----------------- | --------- | ------------------ |
  | choices           | JsonArray | 对话消息列表       |
  | usage             | Json      | 请求完成tokens统计 |
  | prompt_tokens     | Integer   | 请求tokens数       |
  | completion_tokens | Integer   | 返回tokens数       |
  | total_tokens      | Integer   | 总tokens数         |

- 返回代码示例

```
  # 单轮对话
  {
      "id": "chatcmpl-zxbYxSCzeLkGTChVdY43pU",
      "object": "chat.completion",
      "created": 1700036288,
      "model": "vicuna-7b-v1.5-16k",
      "choices": [
          {
              "index": 0,
              "message": {
                  "role": "assistant",
                  "content": "Hello! As an AI language model, I don't have a physical presence or a name, but you can call me Vicuna."
              },
              "finish_reason": "stop"
          }
      ],
      "usage": {
          "prompt_tokens": 46,
          "total_tokens": 75,
          "completion_tokens": 29
      }
  }
  
  # 多轮对话
  {
      "id": "chatcmpl-35vU3H9heSsjsikLzEaUgR",
      "object": "chat.completion",
      "created": 1700036316,
      "model": "vicuna-7b-v1.5-16k",
      "choices": [
          {
              "index": 0,
              "message": {
                  "role": "assistant",
                  "content": "The 2020 World Series was played at Globe Life Field in Arlington, Texas, and at Fall Classic Park in San Diego, California."
              },
              "finish_reason": "stop"
          }
      ],
      "usage": {
          "prompt_tokens": 58,
          "total_tokens": 91,
          "completion_tokens": 33
      }
  }
```
  

#### 2.1 接口名称

Completions：给定一个提示，模型将返回预测的完成结果。

#### 2.2 请求说明

- HTTP方法：POST

- 请求地址：/v1/completions

- Header参数：Content-Type: application/json

- Body参数

  | 参数        | 是否必选 | 类型    | 说明                         |
  | ----------- | -------- | ------- | ---------------------------- |
  | model       | 是       | String  | 模型名称                     |
  | prompt      | 是       | String  | 提示词                       |
  | max_tokens  | 否       | Integer | 返回最大tokens数             |
  | temperature | 否       | Number  | 取值范围为0到2，值越大越随机 |

- 请求代码示例

```
  curl http://{网关地址}/{能力ID}/v1/completions?accessToken=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhYmlsaXR5U3RhdHVzIjoiMSIsImFiaWxpdHlOYW1lIjoiQ2hhdEdMTSIsImNsdXN0ZXJOYW1lIjoiaG9zdCIsImFwcElkIjoiNmI1MWM2ODU4NjAxNGM4YTA1MTg5NWI4ZWUyNTRmODkiLCJhYmlsaXR5QXJlYSI6IjAiLCJhYmlsaXR5U3VwcGxpZXIiOiLlubPlj7AiLCJ1c2VyTmFtZSI6InB0aGVuYW4iLCJhYmlsaXR5SWQiOiJhcHAtMDcwOTM2NDZwYnlnIiwiZnJvbUNvbXBhbnkiOiJoZW5hbiIsImV4cCI6MTcwMDAzMzQ5OCwiaWF0IjoxNzAwMDI5ODk4fQ.KHGWKbkDnLpQ7Jk431ONOE_CIsWwuAf_conNjcc3p3Q \
    -H "Content-Type: application/json" \
    -d '{
      "model": "vicuna-7b-v1.5-16k",
      "prompt": "Once upon a time",
      "max_tokens": 41,
      "temperature": 0.5
    }'
```

#### 2.3 返回说明

- 返回参数

  | 参数              | 类型      | 说明               |
  | ----------------- | --------- | ------------------ |
  | choices           | JsonArray | 预测文本列表       |
  | usage             | Json      | 请求完成tokens统计 |
  | prompt_tokens     | Integer   | 请求tokens数       |
  | completion_tokens | Integer   | 返回tokens数       |
  | total_tokens      | Integer   | 总tokens数         |

- 返回代码示例

```
  {
      "id": "cmpl-3JYawtkqauEoHBaMywPXnQ",
      "object": "text_completion",
      "created": 1700036360,
      "model": "vicuna-7b-v1.5-16k",
      "choices": [
          {
              "index": 0,
              "text": ", there was a young girl named Jocelyn who lived in a small village nestled in the heart of the forest. everybody loved her because of her beautiful voice and her kind heart.b.",
              "logprobs": null,
              "finish_reason": "length"
          }
      ],
      "usage": {
          "prompt_tokens": 5,
          "total_tokens": 45,
          "completion_tokens": 40
      }
  }
```

#### 3.1 接口名称

Embeddings：获取一个给定输入的向量表示，可以方便地被机器学习模型和算法使用。

#### 3.2 请求说明

- HTTP方法：POST

- 请求地址：/v1/embeddings

- Header参数：Content-Type: application/json

- Body参数

  | 参数  | 是否必选 | 类型   | 说明     |
  | ----- | -------- | ------ | -------- |
  | model | 是       | String | 模型名称 |
  | input | 是       | String | 输入文本 |

- 请求代码示例

```
  curl http://{网关地址}/{能力ID}/v1/embeddings?accessToken=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhYmlsaXR5U3RhdHVzIjoiMSIsImFiaWxpdHlOYW1lIjoiQ2hhdEdMTSIsImNsdXN0ZXJOYW1lIjoiaG9zdCIsImFwcElkIjoiNmI1MWM2ODU4NjAxNGM4YTA1MTg5NWI4ZWUyNTRmODkiLCJhYmlsaXR5QXJlYSI6IjAiLCJhYmlsaXR5U3VwcGxpZXIiOiLlubPlj7AiLCJ1c2VyTmFtZSI6InB0aGVuYW4iLCJhYmlsaXR5SWQiOiJhcHAtMDcwOTM2NDZwYnlnIiwiZnJvbUNvbXBhbnkiOiJoZW5hbiIsImV4cCI6MTcwMDAzMzQ5OCwiaWF0IjoxNzAwMDI5ODk4fQ.KHGWKbkDnLpQ7Jk431ONOE_CIsWwuAf_conNjcc3p3Q \
    -H "Content-Type: application/json" \
    -d '{
      "model": "vicuna-7b-v1.5-16k",
      "input": "Hello world!"
    }'
```

#### 3.3 返回说明

- 返回参数

  | 参数          | 类型      | 说明               |
  | ------------- | --------- | ------------------ |
  | data          | JsonArray | 向量表示列表       |
  | usage         | Json      | 请求完成tokens统计 |
  | prompt_tokens | Integer   | 请求tokens数       |
  | total_tokens  | Integer   | 总tokens数         |

- 返回代码示例

```
  {
      "object": "list",
      "data": [
          {
              "object": "embedding",
              "embedding": [
                  0.0232893917709589,
                  -0.019512031227350235,
                  0.008009453304111958,
                  0.016590215265750885,
                  ...
              ],
              "index": 0
          }
      ],
      "model": "vicuna-7b-v1.5-16k",
      "usage": {
          "prompt_tokens": 4,
          "total_tokens": 4
      }
  }
```

## 错误码

| 错误码 | 错误信息                      | 描述                     | 处理建议                     |
| ------ | ----------------------------- | ------------------------ | ---------------------------- |
| -98432 | SENSITIVE_WORD_ERROR          | 请求信息中存在敏感词     | 修改请求内容，避免包含敏感词 |
| -98433 | TOKEN_LIMIT_DAY               | 超过每天tokens阈值总量   | 通过订阅修改工单提高阈值     |
| -98434 | INVALID_RESPONSE_CONTENT_TYPE | 非法响应Content-Type类型 | 请求中避免开启流式返回       |
| 40303  | CONTEXT_OVERFLOW              | 超过模型支持最大长度     | 减小请求内容长度后重试       |
| 50002  | CUDA_OUT_OF_MEMORY            | 显卡内存不足             | 减小请求内容长度后重试       |

