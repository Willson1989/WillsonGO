# 网络协议

网络协议是网络中传递、管理信息的规范。它是应用于至少两个个体之间的约定。如果两个个体之间使用不同的协议，那么它们就没有办法通信。

互联网中不只有 HTTP 协议，根据使用场景的不同存在很多协议。例如 HTTP 协议是用来在计算机网络中传递文字、图片、音视频等超文本数据的通信协议，SMTP 协议是用于邮件系统中进行邮件数据发送的，TELNET 协议是用于电话会议的等等。

需要知道的是，网络协议并不是代码、程序或者API，它是一系列规范，然和操作系统或者应用程序需要根据这个规范来用代码实现它。针对某一个协议的细节在RFC文档中会有详细的描述。

# OSI 标准模型 

ISO（国际标准化组织）将复杂的计算机网络体系和协议分为了 7 个层次，称为OSI 标准模型。每一层不仅包含抽象的概念和数据，还包括具体的协议。

从软件到底层物理硬件层分为：

```
应用层，表示层、会话层、传输层、网络层、数据链路层、物理层
```

在网络通信中，主机之间通信的数据包会依据这个模型从上到下（从应用层到物理层）进行封装，当数据封装完毕之后，再向外发出。

1. **应用层**

   标准模型的最顶层，为应用程序提供服务，如 HTTP、HTTPS、FTP、SMTP

2. **表示层**

   负责数据格式的转换、翻译、编解码、压缩，加密解密

3. **会话层**

   在两个通信结点之间建立、维护和释放面向用户的连接，对会话进行管理和控制，保证数据可靠传输

4. **传输层**

   建立端到端的连接，为网络层和会话层提供服务，提供数据传输服务。

   传输方式：流数据（TCP）、数据报（UDP）

5. **网络层**

   根据IP地址完成寻址、子网传输。主要协议是IP协议。涉及到硬件是路由器

6. **数据链路层**

   网络介质的访问和链路的管理，通过MAC地址完成端到端的数据传输。涉及到网卡、网桥、交换机等硬件。

7. **物理层**

   OSI模型的最底层，描述网络传输的物理介质，以比特流的方式（0和1）在通信信道上传输原始数据。

   

# TCP/IP 协议簇

TCP/IP 协议簇是平时程序员接触最多的协议，但它不是一个具体的协议而是一系列协议的总称，它是一个协议簇。

在TCP/IP 协议簇中，OSI模型的7层被简化为了 4 层：

```
应用层、传输层、网络层、通信链路层
```

OSI模型中的应用层、表示层、会话层所提供的服务相差不是很大，都比较相似，所以合并为了应用层。

OSI模型中的数据链路层、物理层都是涉及底层硬件的的，所以合并为了通信链路层。

<img src="/Users/fn-273/Desktop/640.webp" alt="640" style="zoom:67%;" />

### TCP/IP 中的常用协议

##### · TCP 协议

TCP协议（Tranmission Control Protocol， 传输控制协议）是一种面向连接的、数据可靠的、有时序性、基于字节流的传输协议。TCP位于传输层，当两台主机需要先互相确认并建立连接才能发送数据流，断开连接的时候也需要互相确认。TCP协议是TCP/IP协议栈的核心。



##### · UDP 协议

UDP协议（User Datagram Protocol， 用户数据报协议）也是传输层的协议，它常常用来和TCP进行比较。UDP不是面向连接的传输协议，它提供一种不可靠的数据传输，在传输之前不需要和目标主机建立连接。UDP 只需要知道目标地址和端口号就可以发送数据，因此也不需要对方的应答。虽然不可靠，但是UDP的效率较高，实时性较好。



##### · IP协议

IP协议（Internet Protocol, 网际协议）



##### · ARP 协议

ARP协议（Address Resolution Protocol， 地址解析协议）的主要工作就是建立 IP 地址到 MAC 地址的映射，即用IP地址通过ARP协议可以查到目标的MAC地址。在网络通信中，如果想要和一个目标主机通信，不光要知道IP地址（网络层），还要知道目标的MAC地址（通信链路层）。就好比要给一个人邮寄东西，只填写收件人是不够的，还要写明收件地址。

当发送主机想要获取目标主机的物理地址时，将目标主机的IP、自己的IP和MAC地址加到消息中然后广播到局域网上的所有主机上，如果某个主机匹配了IP地址，就会将自己的MAC地址返回给发送主机。发送主机收到MAC地址之后会缓存到一个表中，下次需要的时候通过IP地址获取到目标的MAC地址。



##### · FTP 协议

FTP协议（File Transfer Protocol， 文件传输协议）是专门用于传输文件的协议，位于应用层。FTP 是C/S 架构，与 HTTP 不同的是服务端会使用两个端口，一个是命令端口（端口号一般为21）、一个是数据端口（端口号一般为20）。命令一般是一些操作比如登录、改变目录、删除文件等。数据端口则用来传输文件例如上传文件、下载文件、显示列表等等。

FTP 会以两种模式来互相通知端口号并传输文件数据，分别是 **主动模式（PORT）**和 **被动模式（PASV）**

**1.主动模式（服务端主动建立连接）**

客户端先生成端口 P 与服务器的21端口（控制端口）建立连接，之后客户端再开放一个 P+1 端口通过PORT命令经由控制端口的连接告知服务器，服务器会从20端口（数据端口）主动连接到客户端的 P+1 端口，之后的文件传输都会在 p+1 端口和 20端口（数据端口）之间进行。

**2.被动模式（服务端被动建立连接）**

上面的主动模式中服务端要主动连接客户端，但由于客户端防火墙的存在，连接可能会被阻塞。为了解决这个问题，FTP 还可以使用被动模式。被动模式下客户端会打开两个端口（N 和 N+1）,客户端从端口 N 发送 PASV 控制命令到服务器的21端口，服务器会将它的数据端口号（P）返回给客户端，然后客户端会主动建立从 N+1 端口到 P 端口的连接，后续的文件传输会在这两个端口之间进行。

**· ICMP协议**



# TCP 和  UDP

## UDP

## TCP





# 文章参考

[理解OSI参考模型](https://www.cnblogs.com/evablogs/p/6709707.html)

[ARP协议 - 概述和原理](https://www.cnblogs.com/csguo/p/7527303.html)

[FTP协议 - 讲解以及使用 Socket 通信实现 FTP 客户端程序](https://www.ibm.com/developerworks/cn/linux/l-cn-socketftp/#ibm-pcon)

[IP协议 - 原理与实践](https://zhuanlan.zhihu.com/p/29287795)



**· RFC官方网站：**

 http://www.rfc-editor.org/

 http://www.ietf.org/rfc.html

 **· RFC文档列表：**

http://www.rfc-editor.org/rfc/

**· 中文RFC文档：**

http://oss.org.cn/man/develop/rfc/default.htm