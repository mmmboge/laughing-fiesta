## 模型介绍

Llama2是由Meta开源的大语言模型，它在各种基准集的测试上表现突出，并且在大多数基准测试中都优于开源聊天模型。Llama2还提供了对微调和安全改进方法的详细描述，为开源社区做出贡献。总的来说，Llama2是一个强大且具有广泛应用前景的大语言模型，可以针对用户的问题和要求提供适当的答复和支持。

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
      "model": "llama-2-7b-chat",
      "messages": [{"role": "user", "content": "Hello! What is your name?"}]
    }'
  
  # 多轮对话
  curl http://{网关地址}/{能力ID}/v1/chat/completions?accessToken=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhYmlsaXR5U3RhdHVzIjoiMSIsImFiaWxpdHlOYW1lIjoiQ2hhdEdMTSIsImNsdXN0ZXJOYW1lIjoiaG9zdCIsImFwcElkIjoiNmI1MWM2ODU4NjAxNGM4YTA1MTg5NWI4ZWUyNTRmODkiLCJhYmlsaXR5QXJlYSI6IjAiLCJhYmlsaXR5U3VwcGxpZXIiOiLlubPlj7AiLCJ1c2VyTmFtZSI6InB0aGVuYW4iLCJhYmlsaXR5SWQiOiJhcHAtMDcwOTM2NDZwYnlnIiwiZnJvbUNvbXBhbnkiOiJoZW5hbiIsImV4cCI6MTcwMDAzMzQ5OCwiaWF0IjoxNzAwMDI5ODk4fQ.KHGWKbkDnLpQ7Jk431ONOE_CIsWwuAf_conNjcc3p3Q \
    -H "Content-Type: application/json" \
    -d '{
      "model": "llama-2-7b-chat",
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
      "id": "chatcmpl-3j8VBFw4TuMveJ4LxCRiea",
      "object": "chat.completion",
      "created": 1700035542,
      "model": "llama-2-7b-chat",
      "choices": [
          {
              "index": 0,
              "message": {
                  "role": "assistant",
                  "content": " Hello! My name is Bard, I'm a large language model trained by Meta AI. How about you? :D"
              },
              "finish_reason": "stop"
          }
      ],
      "usage": {
          "prompt_tokens": 28,
          "total_tokens": 56,
          "completion_tokens": 28
      }
  }
  
  # 多轮对话
  {
      "id": "chatcmpl-3yFjK8XHshvidWZWSUTjM4",
      "object": "chat.completion",
      "created": 1700035622,
      "model": "llama-2-7b-chat",
      "choices": [
          {
              "index": 0,
              "message": {
                  "role": "assistant",
                  "content": " The 2020 World Series was played at Globe Life Field in Arlington, Texas, which is the home stadium of the Texas Rangers. Due to the COVID-19 pandemic, the series was played in a neutral site location to minimize travel and potential exposure to the virus."
              },
              "finish_reason": "stop"
          }
      ],
      "usage": {
          "prompt_tokens": 71,
          "total_tokens": 137,
          "completion_tokens": 66
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
      "model": "llama-2-7b-chat",
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
      "id": "cmpl-3sskeL5ZvVAQCRLSvWYWJ7",
      "object": "text_completion",
      "created": 1700035678,
      "model": "llama-2-7b-chat",
      "choices": [
          {
              "index": 0,
              "text": ", there was a young girl named Sophia who lived in a small village surrounded by vast fields and forests. She had always been fascinated by the beauty of nature and spent most of her days",
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
      "model": "llama-2-7b-chat",
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
                  0.016927259042859077,
                  -0.01455164235085249,
                  0.0020022501703351736,
                  0.009645046666264534,
                  ...
              ],
              "index": 0
          }
      ],
      "model": "llama-2-7b-chat",
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

